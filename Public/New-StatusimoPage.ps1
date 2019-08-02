function New-StatusimoPage {
    [cmdletbinding()]
    param(
        [string] $FilePath,
        [alias('Incident', 'Incidents', 'IncidentPath')][string] $IncidentsPath,
        [alias('Maintenance', 'MaintenancePath')][string] $MaintenancesPath,
        [int] $AutoRefresh
    )
    New-HTML -TitleText 'Services Status' -UseCssLinks:$true -UseJavaScriptLinks:$true -AutoRefresh $AutoRefresh -FilePath $FilePath {

        $Today = Get-Date
        $Incidents = Get-StatusimoData -FolderPath $IncidentsPath | Sort-Object -Property Date, Title -Descending
        $Maintenances = Get-StatusimoData -FolderPath $MaintenancesPath | Sort-Object -Property DateEnd, DateStart, Title -Descending

        $IncidentTypes = $Incidents.Service | Sort-Object -Unique

        New-HTMLSection -Invisible {
            New-HTMLContainer -Width '900px' -Margin 'auto' {
                $Statuses = foreach ($Type in $IncidentTypes) {
                    $Incidents | Where-Object { $_.Service -eq $Type } | Select-Object -First 1 -ExpandProperty Status
                }
                if ($Statuses -notcontains 'Partial Degradation' -and $Statuses -notcontains 'Down') {
                    New-HTMLToast -TextHeader 'Information' -Text 'Everything is running smoothly!' -BarColorLeft Blue -IconSolid info-circle -IconColor Blue
                } else {
                    New-HTMLToast -TextHeader 'Warning' -Text "Some systems are affected. We're hard at work fixing." -BarColorLeft Orange -IconSolid exclamation-circle -IconColor Orange
                }

                New-HTMLHeading -Heading h1 -HeadingText 'Current Status' -Color Black

                New-HTMLStatus {

                    foreach ($Type in $IncidentTypes) {
                        $IncidentStatus = $Incidents | Where-Object { $_.Service -eq $Type } | Select-Object -First 1
                        if ($IncidentStatus.Status -eq 'Operational') {
                            $Icon = 'Good'
                            $Percentage = '100%'
                        } elseif ($IncidentStatus.Status -eq 'Partial Degradation') {
                            $Icon = 'Bad'
                            $Percentage = '30%'
                        } elseif ($IncidentStatus.Status -eq 'Down') {
                            $Icon = 'Dead'
                            $Percentage = '0%'
                        }

                        New-HTMLStatusItem -ServiceName $IncidentStatus.Service -ServiceStatus $IncidentStatus.Status -Icon $Icon -Percentage $Percentage
                    }
                }

                New-HTMLHeading -Heading h1 -HeadingText 'Scheduled Maintenance' -Color Black

                foreach ($Maintenance in $Maintenances) {
                    $Title = "$($Maintenance.Title) ($($Maintenance.DateStart) - $($Maintenance.DateEnd))"
                    if ($Today -ge $Maintenance.DateStart -and $Today -le $Maintenance.DateEnd) {
                        New-HTMLToast -TextHeader $Title  -Text $Maintenance.Overview -BarColorLeft Orange -IconSolid exclamation-circle -IconColor Orange
                    } elseif ($Today -le $Maintenance.DateStart) {
                        New-HTMLToast -TextHeader $Title  -Text $Maintenance.Overview -BarColorLeft Blue -IconSolid info-circle
                    } else {
                        New-HTMLToast -TextHeader $Title -Text $Maintenance.Overview -BarColorLeft Green -IconSolid check-circle -IconColor Green
                    }
                }

                New-HTMLHeading -Heading h1 -HeadingText 'Incidents per day' -Color Black

                $Data = foreach ($Element in 30..0) {
                    $Date = (Get-Date).AddDays(-$Element).Date
                    [Array] $IncidentsPerDay = $Incidents | Where-Object { ($_.Status -eq 'Partial Degradation' -or $_.Status -eq 'Down') -and $_.Date.Date -eq $Date }
                    $IncidentsPerDay.Count
                }
                $DataCategories = foreach ($Element in 30..0) {
                    (Get-Date).AddDays(-$Element).ToShortDateString()
                }
                New-HTMLChart -Title 'Incidents per day' -TitleAlignment left {
                    New-ChartCategory -Name $DataCategories
                    New-ChartLine -Name 'Incidents' -Value $Data
                }

                New-HTMLHeading -Heading h1 -HeadingText 'Timeline' -Color Black

                New-HTMLTimeline {
                    foreach ($Incident in $Incidents) {
                        New-HTMLTimelineItem -HeadingText $Incident.Title -Text $Incident.Overview -Date $Incident.Date -Color Black
                    }
                }
            }
        }
    }
}
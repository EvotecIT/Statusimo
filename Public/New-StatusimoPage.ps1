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

        New-HTMLPanel -Invisible {
            $Statuses = foreach ($Type in $IncidentTypes) {
                $Incidents |  Where-Object { $_.Service -eq $Type  } | Select-Object -First 1 -ExpandProperty Status
            }
            if ($Statuses -notcontains 'Partial Degradation' -and $Statuses -notcontains 'Down') {
                New-HTMLToast -Icon Information -Color Blue -TextHeader 'Information' -Text 'Everything is running smoothly!'
            } else {
                New-HTMLToast -Icon Exclamation -Color Orange -TextHeader 'Warning' -Text "Some systems are affected. We're hard at work fixing."
            }
        }

        New-HTMLHeading -Heading h1 -HeadingText 'Current Status' -Type 'central' -Color Black

        New-HTMLPanel -Invisible {
            New-HTMLStatus {

                foreach ($Type in $IncidentTypes) {
                    $IncidentStatus = $Incidents | Where-Object { $_.Service -eq $Type  } | Select-Object -First 1
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
        }

        New-HTMLHeading -Heading h1 -HeadingText 'Scheduled Maintenance' -Type 'central' -Color Black

        New-HTMLPanel -Invisible {
            foreach ($Maintenance in $Maintenances) {
                $Title = "$($Maintenance.Title) ($($Maintenance.DateStart) - $($Maintenance.DateEnd))"
                if ($Today -ge $Maintenance.DateStart -and $Today -le $Maintenance.DateEnd) {
                    New-HTMLToast -Icon Exclamation -Color Orange -TextHeader $Title -Text $Maintenance.Overview
                } elseif ($Today -le $Maintenance.DateStart) {
                    New-HTMLToast -Icon Information -Color Blue -TextHeader $Title -Text $Maintenance.Overview
                } else {
                    New-HTMLToast -Icon Success -Color Green -TextHeader $Title -Text $Maintenance.Overview
                }
            }
        }


        New-HTMLHeading -Heading h1 -HeadingText 'Incidents per day' -Type 'central' -Color Black

        New-HTMLPanel -Invisible {
            $Data = foreach ($Element in 30..0) {
                $Date = (Get-Date).AddDays(-$Element).Date
                $IncidentsPerDay = $Incidents | Where-Object { ($_.Status -eq 'Partial Degradation' -or $_.Status -eq 'Down') -and $_.Date.Date -eq $Date }
                Get-ObjectCount -Object $IncidentsPerDay
            }
            $DataName = "Incidents"
            $DataCategories = foreach ($Element in 30..0) {
                (Get-Date).AddDays(-$Element).ToShortDateString()
            }

            New-HTMLChart `
                -Data $Data `
                -DataNames $DataName `
                -DataCategories $DataCategories `
                -Type 'line' `
                -TitleText '' `
                -TitleAlignment 'left' `
                -LineColor 'Blue' -Horizontal $false -Positioning central
        }

        New-HTMLHeading -Heading h1 -HeadingText 'Timeline' -Type 'central' -Color Black

        New-HTMLPanel -Invisible {
            New-HTMLTimeline {
                foreach ($Incident in $Incidents) {
                    New-HTMLTimelineItem -HeadingText $Incident.Title -Text $Incident.Overview -Date $Incident.Date -Color Black
                }
            }
        }
    }
}
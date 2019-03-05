function New-StatusimoPage {
    param(
        $FilePath,
        $IncidentsPath
    )
    $DynamicHTML = New-HTML -TitleText 'Services Status' `
        -HideLogos:$true `
        -UseCssLinks:$true `
        -UseStyleLinks:$true {

        $Incidents = Get-StatusimoIncidents -FolderPath $IncidentsPath | Sort-Object -Property Date, Title -Descending
        $IncidentTypes = $Incidents.Service | Sort-Object -Unique
        
    
        New-HTMLColumn -Invisible {
            $Statuses = foreach ($Type in $IncidentTypes) {
                $Incidents |  Where-Object { $_.Service -eq $Type  } | Select-Object -First 1 -ExpandProperty Status
            }
            if ($Statuses -notcontains 'Partial Degradation' -and $Statuses -notcontains 'Down') {
                New-HTMLToast -Icon Information -Color Blue -TextHeader 'Information' -Text 'Everything is running smoothly!'
            } else {
                New-HTMLToast -Icon Exclamation -Color Orange -TextHeader 'Warning' -Text "Some systems are affected. We're hard at work fixing."
            }
        }
    
        New-HTMLHeading -Heading h1 -HeadingText 'Current Status' -Type 'central'
    
        New-HTMLColumn -Columns 1 -Invisible { 
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
    
        New-HTMLHeading -Heading h1 -HeadingText 'Scheduled Maintenance' -Type 'central'
        
        New-HTMLColumn -Invisible {
            New-HTMLToast -Icon Information -Color Orange -TextHeader 'Maintenance' -Text "We've planned maintenance on 24th of January 2020. It will last 30 hours."
        }
    
    
        New-HTMLHeading -Heading h1 -HeadingText 'Incidents per day' -Type 'central'
    
        New-HTMLColumn -Columns 1 -Invisible {
            $Data = foreach ($Element in 30..0) {
                Get-Random -Minimum 0 -Maximum 5
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
    
    
        New-HTMLHeading -Heading h1 -HeadingText 'Past Incidents' -Type 'central'
    
        New-HTMLColumn -Columns 1 -Invisible {    
            New-HTMLTimeline {
                foreach ($Incident in $Incidents) {
                    New-HTMLTimelineItem -HeadingText $Incident.Title -Text $Incident.Overview -Date $Incident.Date
                }
            }
        }
    }
    [string] $DynamicHTMLPath = Save-HTML -HTML $DynamicHTML -FilePath $FilePath
}
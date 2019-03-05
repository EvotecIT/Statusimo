function New-PrepareStatusPage {
    param(
        $FilePath
    )
    $DynamicHTML = New-HTML -TitleText 'Services Status' `
        -HideLogos:$true `
        -UseCssLinks:$true `
        -UseStyleLinks:$true {
    
        New-HTMLColumn -Invisible {
            New-HTMLToast -Icon Information -Color Blue -TextHeader 'Information' -Text 'Everything is running smoothly!'
        }
    
        New-HTMLHeading -Heading h1 -HeadingText 'Current Status' -Type 'central'
    
        New-HTMLColumn -Columns 1 -Invisible { 
            New-HTMLStatus {
                New-HTMLStatusItem -ServiceName 'Active Directory' -ServiceStatus 'Operational' -Icon Good -Percentage '100%'
                New-HTMLStatusItem -ServiceName 'Github' -ServiceStatus 'Operational' -Icon Good -Percentage '100%'
                New-HTMLStatusItem -ServiceName 'Hyper-V' -ServiceStatus 'Non-functional' -Icon Dead -Percentage '0%'
                New-HTMLStatusItem -ServiceName 'Active Directory' -ServiceStatus 'Operational' -Icon Good -Percentage '100%'
                New-HTMLStatusItem -ServiceName 'Azure' -ServiceStatus 'Working on it' -Icon Bad -Percentage '70%'
                New-HTMLStatusItem -ServiceName 'Twitter' -ServiceStatus 'Who knows?!' -Icon Bad -Percentage '30%'
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
                New-HTMLTimelineItem -HeadingText 'Azure AD is down' -Text "We have huge problems" -Date (Get-Date).AddDays(-1)
                New-HTMLTimelineItem -HeadingText 'Azure AD ...' -Text "We have huge problems" -Date (Get-Date).AddDays(-2)
                New-HTMLTimelineItem -HeadingText 'AD just died' -Text "We have huge problems" -Date (Get-Date).AddDays(-3)
                New-HTMLTimelineItem -HeadingText 'Twitter' -Text "We're very soorrry! It just won't work!" -Date (Get-Date).AddDays(-4)
                New-HTMLTimelineItem -HeadingText 'Twitter' -Text "We're very soorrry! It just won't work!" -Date (Get-Date).AddDays(-4)
                New-HTMLTimelineItem -HeadingText 'Twitter' -Text "We're very soorrry! It just won't work!" -Date (Get-Date).AddDays(-4)
                New-HTMLTimelineItem -HeadingText 'Twitter' -Text "We're very soorrry! It just won't work!" -Date (Get-Date).AddDays(-5)
                New-HTMLTimelineItem -HeadingText 'Twitter' -Text "We're very soorrry! It just won't work!" -Date (Get-Date).AddDays(-6)
                New-HTMLTimelineItem -HeadingText 'Twitter' -Text "We're very soorrry! It just won't work!" -Date (Get-Date).AddDays(-7)
            }
        }
    }
    [string] $DynamicHTMLPath = Save-HTML -HTML $DynamicHTML -FilePath $FilePath
}
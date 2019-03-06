$newStatusimoIncidentSplat = @{
    Date       = (Get-Date)
    Overview   = "We're currently experiencing issues. No services are available."
    Title      = 'Exchange Servers are Down'
    Status     = 'Down'
    Service    = 'Exchange'
    Tag        = ''
    FolderPath = "$PSScriptRoot\Incidents"
}
New-StatusimoIncident @newStatusimoIncidentSplat
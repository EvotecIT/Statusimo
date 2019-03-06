Import-Module .\Statusimo.psd1 -Force

$newStatusimoIncidentSplat = @{
    Date = (Get-Date)
    Overview = "We're currently experiencing issues with Active Directory. It may work slower then usual."
    Title = 'Active Directory controller is down'
    Status = 'Partial Degradation'
    Service = 'Active Directory'
    Tag = ''
    FolderPath = "$PSScriptRoot\Incidents"
}
New-StatusimoIncident @newStatusimoIncidentSplat
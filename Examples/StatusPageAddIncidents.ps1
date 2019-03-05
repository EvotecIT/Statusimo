Import-Module .\Statusimo.psd1 -Force

New-StatusimoIncident -FolderPath $PSScriptRoot\Incidents -Date (Get-Date) -Service 'Active Directory' -Status 'Partial Degradation' -Tag '' -Title 'Active Directory controller is down' -Overview "We're currently experiencing issues with Active Directory. It may work slower then usual."
New-StatusimoIncident -FolderPath $PSScriptRoot\Incidents -Date (Get-Date) -Service 'Hyper-V' -Status 'Partial Degradation' -Tag '' -Title 'Hyper-V is having issues' -Overview "We're currently experiencing issues with Hyper-V Cluster."
New-StatusimoIncident -FolderPath $PSScriptRoot\Incidents -Date (Get-Date) -Service 'Hyper-V' -Status 'Operational' -Tag '' -Title 'Hyper-V OK' -Overview "Cluster is fully functional now"

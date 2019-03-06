Import-Module .\Statusimo.psd1 -Force

New-StatusimoIncident -FolderPath $PSScriptRoot\Incidents -Date (Get-Date) -Service 'Hyper-V' -Status 'Operational' -Tag '' -Title 'Hyper-V OK' -Overview "Cluster is fully functional now"

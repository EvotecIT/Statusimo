Import-Module .\Statusimo.psd1 -Force

New-StatusimoPage -FilePath $PSScriptRoot\StatusPage.html -IncidentsPath $PSScriptRoot\Incidents -MaintenancePath $PSScriptRoot\Maintenance
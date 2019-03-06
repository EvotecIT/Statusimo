Import-Module .\Statusimo.psd1 -Force

Remove-StatusimoMaintenance -DaysOld 0 -MaintenancePath $PSScriptRoot\Maintenance
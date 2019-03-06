Import-Module .\Statusimo.psd1 -Force

$newStatusimoMaintenanceSplat = @{
    Title = 'Hyper-V scheduled maintenance'
    DateStart = (Get-Date).AddDays(5)
    DateEnd = (Get-Date).AddDays(6).AddHours(2)
    Service = 'Hyper-V'
    Overview = "Updating core infrastructure for Hyper-V. Servers may be affected."
    FolderPath = "$PSScriptRoot\Maintenance" 
}

New-StatusimoMaintenance @newStatusimoMaintenanceSplat 


$newStatusimoMaintenanceSplat = @{
    Title = 'Hyper-V scheduled maintenance'
    DateStart = (Get-Date).AddDays(-1)
    DateEnd = (Get-Date).AddDays(2).AddHours(2)
    Service = 'Hyper-V'
    Overview = "We will be changing HDD in ClusterX"
    FolderPath = "$PSScriptRoot\Maintenance" 
}

New-StatusimoMaintenance @newStatusimoMaintenanceSplat 


$newStatusimoMaintenanceSplat = @{
    Title = 'Hyper-V scheduled maintenance'
    DateStart = (Get-Date).AddDays(-1)
    DateEnd = (Get-Date).AddDays(-1).AddHours(2)
    Service = 'Hyper-V'
    Overview = "Small cable replacement"
    FolderPath = "$PSScriptRoot\Maintenance" 
}

New-StatusimoMaintenance @newStatusimoMaintenanceSplat 
function Remove-StatusimoMaintenance {
    [cmdletbinding()]
    param(
        [alias('Maintenance', 'MaintenancePath')][string] $MaintenancesPath,
        [int] $DaysOld
    )

    $DateOld = (Get-Date).AddDays($DaysOld)

    $Maintenances = Get-StatusimoData -FolderPath $MaintenancesPath |  Where-Object { $_.DateEnd -lt $DateOld }
    foreach ($Maintenance in $Maintenances) {
        Remove-Item -LiteralPath $Maintenance.FullName -Confirm:$false
    }
}
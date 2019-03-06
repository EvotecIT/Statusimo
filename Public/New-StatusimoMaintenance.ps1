function New-StatusimoMaintenance {
    [cmdletbinding()]
    param(
        [DateTime] $DateStart,
        [DateTime] $DateEnd,
        [string] $Service,
        [ValidateSet('Operational', 'Partial Degradation', 'Down')][string] $Status,
        [string] $Title,
        [string] $Overview,
        [string] $FolderPath
    )
    $FileNameService = $Service -replace '[^a-zA-Z]', '_'
    $FileNameData = $DateStart.ToString("yyyy-MM-dd_HH_MM_ss")
    $FileNameEnd = Get-FileName -Extension 'json' -TemporaryFileOnly
    $FileName = $FileNameService + '_' + $FileNameData + '_' + $FileNameEnd
    $FilePath = [IO.Path]::Combine($FolderPath, $FileName)

    $Maintenance = [ordered] @{
        DateStart = $DateStart
        DateEnd   = $DateEnd
        Service   = $Service
        Status    = $Status
        Title     = $Title
        Overview  = $Overview
    }
    $Output = $Maintenance | ConvertTo-Json
    $Output | Set-Content -LiteralPath $FilePath
    
}
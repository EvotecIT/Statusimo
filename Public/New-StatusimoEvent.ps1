function New-StatusimoEvent {
    [alias('New-StatusimoIncident')]
    [cmdletbinding()]
    param(
        [DateTime] $Date = (Get-Date),
        [string] $Service,
        [ValidateSet('Operational', 'Partial Degradation', 'Down')][string] $Status,
        [string] $Title,
        [string] $Overview,
        [alias('IncidentsPath', 'EventsPath')][string] $FolderPath
    )
    $FileNameService = $Service -replace '[^a-zA-Z]', '_'
    $FileNameData = $Date.ToString("yyyy-MM-dd_HH_MM_ss")
    $FileNameEnd = Get-FileName -Extension 'json' -TemporaryFileOnly
    $FileName = $FileNameService + '_' + $FileNameData + '_' + $FileNameEnd
    $FilePath = [IO.Path]::Combine($FolderPath, $FileName)
    if ($Maintenance) {

    } else {
        $Incident = [ordered] @{
            Date     = $Date
            Service  = $Service
            Status   = $Status
            Title    = $Title
            Overview = $Overview
        }
        $Output = $Incident | ConvertTo-Json
        $Output | Set-Content -LiteralPath $FilePath
    }
}
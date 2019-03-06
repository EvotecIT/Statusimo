function New-StatusimoIncident {
    [cmdletbinding()]
    param(
        [DateTime] $Date = (Get-Date),
        [string] $Service,
        [ValidateSet('Operational', 'Partial Degradation', 'Down')][string] $Status,
        [string] $Tag,
        [string] $Title,
        [string] $Overview,
        [string] $FolderPath
    )
    $FileNameService = $Service -replace '[^a-zA-Z]', '_'
    $FileNameData = $Date.ToString("yyyy-MM-dd_HH_MM_ss")
    $FileNameEnd = Get-FileName -Extension 'json' -TemporaryFileOnly
    $FileName = $FileNameService + '_' + $FileNameData + '_' + $FileNameEnd
    $FilePath = [IO.Path]::Combine($FolderPath, $FileName)

    $Incident = [ordered] @{
        Date     = $Date
        Service  = $Service
        Status   = $Status
        Tag      = $Tag
        Title    = $Title
        Overview = $Overview
    }
    $Output = $Incident | ConvertTo-Json
    $Output | Set-Content -LiteralPath $FilePath
}
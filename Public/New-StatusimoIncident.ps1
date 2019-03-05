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
    $FileName = Get-FileName -Extension 'json' -TemporaryFileOnly
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
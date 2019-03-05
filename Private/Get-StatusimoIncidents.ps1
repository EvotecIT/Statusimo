function Get-StatusimoIncidents {
    param(
        [string] $FolderPath      
    )
    $Files = Get-ChildItem -LiteralPath $FolderPath    
    foreach ($File in $Files) {       
        Get-Content -LiteralPath $File.FullName -Raw | ConvertFrom-Json
    }
}

function Get-StatusimoData {
    [cmdletbinding()]
    param(
        [string] $FolderPath      
    )
    if ($FolderPath -ne '' -and (Test-Path -LiteralPath $FolderPath)) {
        $Files = Get-ChildItem -LiteralPath $FolderPath    
        foreach ($File in $Files) {       
            $Output = Get-Content -LiteralPath $File.FullName -Raw | ConvertFrom-Json
            Add-Member -InputObject $Output -Name 'FullName' -Value $File.FullName -MemberType NoteProperty -Force
            $Output
        }
    } 
}
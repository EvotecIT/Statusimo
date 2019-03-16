function Get-StatusimoData {
    [cmdletbinding()]
    param(
        [string] $FolderPath      
    )
    if ($FolderPath -ne '' -and (Test-Path -LiteralPath $FolderPath)) {
        $Files = Get-ChildItem -LiteralPath $FolderPath    
        foreach ($File in $Files) {       
            $Output = Get-Content -LiteralPath $File.FullName | ConvertFrom-Json      
            $TimeZoneBias = (Get-CimInstance -ClassName Win32_TimeZone).Bias
            $Output.PSObject.Properties | Where-Object {$_.Name -like 'Date*' } | ForEach-Object {
                $Output.($_.Name) = $_.Value.AddMinutes($TimeZoneBias)
            }
            Add-Member -InputObject $Output -Name 'FullName' -Value $File.FullName -MemberType NoteProperty -Force
            $Output
        }
    } 
}
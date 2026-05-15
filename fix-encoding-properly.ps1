$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    # If it's not UTF-8, it might be Latin1
    if ($content -match '') {
        $content = [System.Text.Encoding]::GetEncoding("iso-8859-1").GetString($bytes)
    }

    # Final cleanup of any remaining common artifacts
    $content = $content -replace 'Ã¡', 'á'
    $content = $content -replace 'Ã©', 'é'
    $content = $content -replace 'Ã­', 'í'
    $content = $content -replace 'Ã³', 'ó'
    $content = $content -replace 'Ãº', 'ú'
    $content = $content -replace 'Ã±', 'ñ'
    $content = $content -replace 'Ã', 'Á'
    $content = $content -replace 'Ã‰', 'É'
    $content = $content -replace 'Ã', 'Í'
    $content = $content -replace 'Ã“', 'Ó'
    $content = $content -replace 'Ãš', 'Ú'
    $content = $content -replace 'Ã‘', 'Ñ'
    $content = $content -replace 'Â©', '©'
    $content = $content -replace 'â€”', '—'
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
}

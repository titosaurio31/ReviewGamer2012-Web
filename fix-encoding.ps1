$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # Fix encoding artifacts
    $content = $content -replace 'Â©', '©'
    $content = $content -replace 'Â¡', '¡'
    $content = $content -replace 'Ã³', 'ó'
    $content = $content -replace 'Ã­', 'í'
    $content = $content -replace 'Ã©', 'é'
    $content = $content -replace 'Ã¡', 'á'
    $content = $content -replace 'Ã±', 'ñ'
    $content = $content -replace 'Ã', 'í' # Common misstep
    $content = $content -replace 'íº', 'ú'
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
}

$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Defer Google Fonts loading
    $content = $content -replace '<link href="https://fonts\.googleapis\.com/css2([^"]+)" rel="stylesheet">', '<link rel="preload" as="style" href="https://fonts.googleapis.com/css2$1" /><link rel="stylesheet" href="https://fonts.googleapis.com/css2$1" media="print" onload="this.media=''all''" />'
    
    # Also optimize DOM size by removing unnecessary comments if any
    $content = $content -replace '<!--[\s\S]*?-->', ''
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

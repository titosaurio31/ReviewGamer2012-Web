$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # 1. Fix DOCTYPE (remove 'b ' or random bytes at start)
    $content = $content -replace '(?s)^.*?<!DOCTYPE html>', '<!DOCTYPE html>'
    
    # 2. Add Meta Description if missing
    if ($content -notmatch '<meta name="description"') {
        $content = $content -replace '<head>', "<head>`r`n  <meta name=`"description`" content=`"Descubre las mejores reseñas de periféricos gamer, consolas y accesorios para mejorar tu setup y experiencia de juego.`">"
    }
    
    # 3. Save as UTF-8 without BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
}

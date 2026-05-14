$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # We want to replace the first occurrence of loading="lazy" in the first <img> tag with fetchpriority="high"
    # Or simply replace loading="lazy" in the gallery-main img
    
    $content = $content -replace '<div class="gallery-main">\s*<img src="([^"]+)" alt="([^"]*)" loading="lazy"', '<div class="gallery-main">`r`n            <img src="$1" alt="$2" fetchpriority="high" decoding="sync"'
    
    # Also for files that have hero-image
    $content = $content -replace '<img src="([^"]+)" alt="([^"]*)" style="object-fit: contain;" loading="lazy"', '<img src="$1" alt="$2" style="object-fit: contain;" fetchpriority="high" decoding="sync"'
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

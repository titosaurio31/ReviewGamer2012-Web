$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # Correct DOCTYPE if corrupted
    $content = $content -replace '^b <!DOCTYPE html>', '<!DOCTYPE html>'
    
    # Correct common corrupted footer links
    $content = $content -replace 'href="javascript:void\(0\)"', 'href="#"'
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
}

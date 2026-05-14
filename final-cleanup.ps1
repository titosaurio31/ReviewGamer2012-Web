$htmlFiles = Get-ChildItem -Filter *.html -Recurse
foreach ($file in $htmlFiles) {
    # Read as UTF-8
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Specific artifact fixes based on 'ǽ' and 'ǟ' patterns
    $content = $content -replace "ǽ'", '"'
    $content = $content -replace 'ǽ\?', '"'
    $content = $content -replace 'ǽ\?', '"'
    $content = $content -replace "ǽ'\?", '"'
    $content = $content -replace "ǽ'\?\?", '"'
    $content = $content -replace 'ǟ', 'ñ'
    $content = $content -replace 'ǟ', 'ñ'
    $content = $content -replace 'ǟ', 'ñ'
    $content = $content -replace 'ǟ', 'ó' # Sometimes ó becomes this
    $content = $content -replace 'ǟ', 'í' # Sometimes í becomes this
    $content = $content -replace 'ǟ', 'í'
    $content = $content -replace 'ǟ', 'á'
    $content = $content -replace 'ǟ', 'é'
    $content = $content -replace 'ǟ', 'ú'
    $content = $content -replace 'ǟ', 'í'
    $content = $content -replace 'ǟ', 'í'
    $content = $content -replace 'Ǹ', 'í'
    $content = $content -replace 'ǟ', 'ó'
    $content = $content -replace 'ǟ', 'ñ'
    $content = $content -replace '', '©'
    $content = $content -replace 'ǟ', 'ñ'
    $content = $content -replace 'ǟ', 'ó'
    $content = $content -replace 'ǟ', 'í'
    $content = $content -replace 'ǟ', 'á'
    $content = $content -replace 'ǟ', 'é'
    $content = $content -replace 'ǟ', 'ú'

    # General cleanup for common Spanish characters if they still look like ǽ
    $content = $content -replace 'ǟ', 'ñ'
    $content = $content -replace 'ǟ', 'ó'
    $content = $content -replace 'ǟ', 'á'
    $content = $content -replace 'ǟ', 'í'
    $content = $content -replace 'ǟ', 'é'
    $content = $content -replace 'ǟ', 'ú'

    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
}

Add-Type -AssemblyName System.Drawing
$images = Get-ChildItem -Path "c:\Users\DELL\Desktop\proyectos\assets" -Include *.jpg, *.png -Recurse | Where-Object { $_.Length -gt 500KB }

foreach ($img in $images) {
    try {
        $bitmap = [System.Drawing.Image]::FromFile($img.FullName)
        
        # Calculate new size (max width 800)
        $maxWidth = 800
        if ($bitmap.Width -gt $maxWidth) {
            $ratio = $maxWidth / $bitmap.Width
            $newWidth = $maxWidth
            $newHeight = [math]::Round($bitmap.Height * $ratio)
            
            $newBitmap = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
            $g = [System.Drawing.Graphics]::FromImage($newBitmap)
            $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.DrawImage($bitmap, 0, 0, $newWidth, $newHeight)
            
            $bitmap.Dispose()
            
            # Save over original
            $newBitmap.Save($img.FullName, [System.Drawing.Imaging.ImageFormat]::Jpeg)
            $newBitmap.Dispose()
            $g.Dispose()
            Write-Host "Resized $($img.Name)"
        } else {
            $bitmap.Dispose()
        }
    } catch {
        Write-Host "Error processing $($img.Name): $_"
    }
}

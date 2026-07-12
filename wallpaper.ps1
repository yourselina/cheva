# DELAY
Start-Sleep -Seconds 15

# 1. Download wallpaper
$imageUrl = "https://github.com/Mafin111/MafinREP111/raw/refs/heads/main/photo.jpg"
$imagePath = "C:\Users\Public\wallpaper.jpg"

try {
    # Using Invoke-WebRequest to download a file
    Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath
    Write-Host "Wallpaper successfully downloaded to: $imagePath"
} catch {
    Write-Host "Error downloading wallpaper: $_"
    exit 1
}

# 2. Defining an API function for setting wallpaper
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# 3. Instant wallpaper installation
try {
    [Wallpaper]::SystemParametersInfo(20, 0, $imagePath, 0x01 -bor 0x02)
    Write-Host "Wallpaper installed successfully!"
} catch {
    Write-Host "Error installing wallpaper: $_"
}


$file = Get-ChildItem -Path "C:\Users\T495" -Recurse -Filter "*.webp" -ErrorAction SilentlyContinue | 
    Where-Object { $_.LastWriteTime -gt (Get-Date).AddMinutes(-10) } | 
    Sort-Object LastWriteTime -Descending | 
    Select-Object -First 1

if ($file) {
    Write-Host "Found: $($file.FullName)"
    Copy-Item $file.FullName "c:\Users\T495\Desktop\graduation_project\assets\images\onboarding\onboarding3.png" -Force
    Write-Host "Copied successfully to onboarding3.png"
} else {
    Write-Host "No recent webp file found"
}

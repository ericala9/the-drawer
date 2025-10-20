Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.BalloonTipTitle = "Folder Checker"
$notify.BalloonTipText = $args[0]
$notify.Visible = $true

# Show balloon for 10 seconds
$notify.ShowBalloonTip(10000)

# Keep tray icon until manually closed or script ends
Write-Host "Tray icon is active. Press Enter to remove it."
Read-Host | Out-Null

# Remove tray icon after confirmation
$notify.Dispose()
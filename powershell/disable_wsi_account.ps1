# disable_wsiaccount.ps1
# Disables the WsiAccount system user if found.

$account = Get-LocalUser -Name "WsiAccount" -ErrorAction SilentlyContinue

if ($account) {
    if ($account.Enabled) {
        Disable-LocalUser -Name "WsiAccount"
        Write-Output "✅ WsiAccount found and disabled."
    } else {
        Write-Output "ℹ️ WsiAccount already disabled."
    }
} else {
    Write-Output "❌ WsiAccount not found on this system."
}

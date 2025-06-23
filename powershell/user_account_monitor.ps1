# user_account_monitor.ps1
# Script to detect newly created user accounts via Security Event Log (Event ID 4720)
# Triggers a popup alert if new accounts are found

Add-Type -AssemblyName System.Windows.Forms

$logName = "Security"
$eventId = 4720
$lastCheck = (Get-Date).AddMinutes(-5)

$events = Get-WinEvent -FilterHashtable @{
    LogName   = $logName
    Id        = $eventId
    StartTime = $lastCheck
} | Select-Object TimeCreated, Message

if ($events) {
    foreach ($event in $events) {
        [System.Windows.Forms.MessageBox]::Show("🚨 New user account created: $($event.TimeCreated)`nCheck Event Viewer for details.", "User Account Alert", 'OK', 'Warning')
    }
} else {
    # Uncomment below to debug or silently log
    # [System.Windows.Forms.MessageBox]::Show("No new user accounts created.", "User Monitor", 'OK', 'Information')
}

Param(
    [int]$InactiveDays = 90
)
#Configure Output File
$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$timestamp = Get-Date -UFormat %Y%m%d-%H%M
$random = -join(48..57+65..90+97..122 | ForEach-Object {[char]$_} | Get-Random -Count 6)
$reportfile = "$mydir\InactiveAccounts-$timestamp-$random.csv"
Import-Module ActiveDirectory

Search-ADAccount -UsersOnly -AccountInactive -TimeSpan "$InactiveDays" | `
Get-ADUser -Properties Name, sAMAccountName, givenName, sn, userAccountControl,lastlogondate | `
Where {($_.userAccountControl -band 2) -eq $False} | Select Name, sAMAccountName, givenName, sn,LastLogonDate | `
Export-Csv $reportfile -NoTypeInformation

Write-Host -ForegroundColor White "Report written to $reportfile in current path."
Get-Item $reportfile

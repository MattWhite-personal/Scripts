#Configure Output File
$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$timestamp = Get-Date -UFormat %Y%m%d-%H%M
$random = -join(48..57+65..90+97..122 | ForEach-Object {[char]$_} | Get-Random -Count 6)
$reportfile = "$mydir\PasswordLastSet-$timestamp-$random.csv"
Import-Module ActiveDirectory

Get-ADUser -filter * -properties passwordlastset, passwordneverexpires | `
Where {($_.userAccountControl -band 2) -eq $False} | `
sort-object name | `
select-object Name, passwordlastset, passwordneverexpires | `
Export-csv -path $reportfile -NoTypeInformation

Write-Host -ForegroundColor White "Report written to $reportfile in current path."
Get-Item $reportfile

# Get-ADInactiveAccounts

The **Get-ADInactiveAccounts** PowerShell script is designed to search for inactive user accounts in Active Directory. It retrieves users who have not logged in within a specified number of days and generates a CSV report with key details of these accounts.

## Features

- **Configurable Inactivity Threshold**  
  The script accepts an `-InactiveDays` parameter (default is 90 days) that determines how long an account must be inactive to be included in the report.

- **Dynamic Report File Generation**  
  The output report file is dynamically named using the current date, time, and a random string to avoid name collisions.

- **User Information Retrieval**  
  The script gets detailed information for each user account including:  
  - Name  
  - sAMAccountName  
  - Given Name  
  - Surname  
  - Last Logon Date

- **Filtered Inactive Accounts**  
  It excludes accounts that are marked as disabled by checking the `userAccountControl` attribute.

## Prerequisites

- **Active Directory Module**  
  The system needs to have the ActiveDirectory PowerShell module installed and imported. This module is used for cmdlets like `Search-ADAccount` and `Get-ADUser`.

- **Proper Permissions**  
  Ensure the user running the script has sufficient permissions to query Active Directory.

## Usage

1. Open PowerShell with appropriate privileges.
2. Navigate to the directory where the script is located:
   ```powershell
   cd path\to\Get-ADInactiveAccounts
   ```
3. Execute the script:
   ```powershell
   .\Get-ADInactiveAccounts.ps1 -InactiveDays 90
   ```
   You can change the `-InactiveDays` parameter to suit your requirements.

## Output

- **CSV Report File**  
  The report is saved as a CSV file in the same directory as the script. The file is named using the format:  
  `InactiveAccounts-YYYYMMDD-HHMM-random.csv`  
  where `YYYYMMDD` is the date, `HHMM` is the time, and `random` is a random alphanumeric string.

- **Confirmation Message**  
  The script outputs a confirmation message indicating the location of the generated report, and it retrieves the file details.

## Example

Below is an example output in the PowerShell terminal after running the script:
```powershell
Report written to C:\Scripts\Get-ADInactiveAccounts\InactiveAccounts-20250723-1356-ABC123.csv in current path.
```

## Notes

- Ensure the active directory environment is accessible from the machine where you run this script.
- Modify or enhance the script as needed to fit specific requirements in your Active Directory environment.

## Author

Authored by [@MattWhite-personal](https://github.com/MattWhite-personal).

For further discussions and background on this script, read the original blog post: [Reporting on Inactive AD User Accounts](https://matthewjwhite.co.uk/2015/10/27/reporting-on-inactive-ad-user-accounts/).

Happy scripting!

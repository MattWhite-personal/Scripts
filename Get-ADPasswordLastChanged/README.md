# Get-ADPasswordLastChanged

The **Get-ADPasswordLastChanged** PowerShell script is designed to retrieve information about Active Directory user password settings. It generates a CSV report containing the date when each user's password was last set, as well as whether their password never expires.

## Features

- **Dynamic Report File Generation**  
  The script dynamically generates a unique CSV file name using the current date, time, and a random alphanumeric string to prevent file name conflicts.

- **User Information Retrieval**  
  It collects key details for each AD user including:  
  - Name  
  - Date when the password was last set (`passwordlastset`)  
  - Whether the password is configured to never expire (`passwordneverexpires`)

- **Sorted Output**  
  The output is sorted alphabetically by user name, making it easier to browse the report.

- **Filtered Disabled Accounts**  
  The script excludes disabled user accounts by filtering with the `userAccountControl` attribute.

## Prerequisites

- **Active Directory Module**  
  Ensure that the ActiveDirectory PowerShell module is installed and imported, as it provides the necessary cmdlets like `Get-ADUser`.

- **Sufficient Permissions**  
  The user executing the script must have appropriate permissions to query the Active Directory.

## Usage

1. Open PowerShell with administrator or proper user privileges.
2. Navigate to the directory containing the script:
   ```powershell
   cd path\to\Get-ADPasswordLastChanged
   ```
3. Run the script:
   ```powershell
   .\Get-ADPasswordLastChanged.ps1
   ```
   The script will generate a CSV report file in the same directory with a name formatted as:
   ```
   PasswordLastSet-YYYYMMDD-HHMM-random.csv
   ```
   where `YYYYMMDD` is the date, `HHMM` is the time, and `random` is a random alphanumeric string.

## Output

- **CSV Report File**  
  The report is saved in the execution directory and includes details for each user regarding their last password change and password expiration setting.

- **Confirmation Message**  
  Upon completion, the script outputs a message indicating the report file's path and retrieves the file details.

## Example

Below is an example of what you might see in the PowerShell terminal after running the script:
```powershell
Report written to C:\Scripts\Get-ADPasswordLastChanged\PasswordLastSet-20250723-1402-ABC123.csv in current path.
```

## Notes

- Verify that your environment’s Active Directory is accessible before running the script.
- Modify or enhance the script to suit additional specific requirements of your AD environment if needed.

## Author

Authored by [@MattWhite-personal](https://github.com/MattWhite-personal).

For further details and background on this script, refer to the original blog post: [Reporting on AD Users' Last Password Change](https://matthewjwhite.co.uk/2015/10/27/reporting-on-ad-users-last-password-change/).

Happy scripting!

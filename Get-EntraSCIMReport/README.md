# Get-EntraSCIMReport.ps1

## Overview

`Get-EntraSCIMReport.ps1` is a PowerShell script that audits all Service Principals in Microsoft Entra ID (formerly Azure AD) to determine which ones have SCIM (System for Cross-domain Identity Management) synchronization jobs configured. The script outputs a CSV report summarizing the SCIM provisioning status for each Service Principal.

This utility is valuable for IT administrators who need to monitor, audit, or troubleshoot SCIM provisioning across enterprise applications in Entra ID.

For a detailed walkthrough and background, see the blog post:  
[Entra SCIM Report – Audit SCIM Provisioning Jobs in Entra ID](https://matthewjwhite.co.uk/2025/07/12/entra-scim-report/)

---

## Features

- Enumerates all Service Principals in your Entra tenant.
- Checks for SCIM synchronization job configuration per Service Principal.
- Optionally includes Service Principals without SCIM jobs.
- Exports results to a CSV file for easy review and analysis.

---

## Prerequisites

- PowerShell 7.x or later (recommended).
- Microsoft Graph PowerShell modules installed:
  ```powershell
  Install-Module Microsoft.Graph -Scope CurrentUser
  ```
- Permissions to read Service Principals and Synchronization Jobs (e.g., Application Administrator or higher).
- Access to a valid export path for the CSV report.

---

## Usage

1. **Clone or download this script:**

   ```powershell
   git clone https://github.com/MattWhite-personal/Scripts.git
   cd Scripts/Get-EntraSCIMReport
   ```

2. **Run the script with required parameters:**

   ```powershell
   .\Get-EntraSCIMReport.ps1 -exportPath "C:\Reports\SCIMReport.csv"
   ```

   This outputs only Service Principals with SCIM jobs.

   To include all Service Principals (including those without SCIM jobs):

   ```powershell
   .\Get-EntraSCIMReport.ps1 -exportPath "C:\Reports\SCIMReport.csv" -reportAll $true
   ```

3. **Parameters:**
   - `-exportPath` (required): Path to save the CSV report.
   - `-reportAll` (optional, default: `$false`): If `$true`, includes Service Principals without SCIM jobs.

---

## Example Output

The generated CSV will include:

| ServicePrincipalId                        | ServicePrincipalDisplayName | Job                  |
|-------------------------------------------|----------------------------|----------------------|
| 00000000-0000-0000-0000-000000000000      | My SCIM App                | SCIM is configured   |
| 11111111-2222-3333-4444-555555555555      | Some Other App             | SCIM is not configured |

---

## Troubleshooting

- **Module errors:**  
  Ensure the Microsoft Graph PowerShell modules are installed.

- **Permission errors:**  
  Make sure your account has sufficient permissions (`Synchronization.Read.All`, `Application.Read.All`).

- **Path errors:**  
  The parent directory for your export path must exist.

- **Authentication:**  
  The script will prompt for authentication if not already connected.

---

## License

This script is provided under the [MIT License](../LICENSE).

---

## Author

Matthew J. White  
For a detailed explanation and walkthrough, see the blog post:  
[https://matthewjwhite.co.uk/2025/07/12/entra-scim-report/](https://matthewjwhite.co.uk/2025/07/12/entra-scim-report/)

---
*Contributions and suggestions welcome!*

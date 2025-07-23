# Set-WindowsMappedDrives.ps1

## Overview

`Set-WindowsMappedDrives.ps1` is a PowerShell script designed to automate the mapping of network drives based on Azure AD group membership. The script authenticates the user via Azure AD, retrieves their group memberships using Microsoft Graph API, and maps drives according to a configurable list. It is intended for deployment via Intune or similar management tools.

For more detail and background, see the related blog post:  
[Mapping legacy file shares for Azure AD joined devices](https://matthewjwhite.co.uk/2019/04/07/mapping-legacy-files-shares-for-azure-ad-joined-devices/)

## Features

- Authenticates users with Azure AD using OAuth2.
- Retrieves group memberships via Microsoft Graph API.
- Maps network drives based on group inclusion/exclusion.
- Logs execution to a file in `C:\ProgramData\Intune-PowerShell-Logs`.
- Designed for use in system context (e.g., Intune).

## Prerequisites

- Azure AD Application Registration with required API permissions (`User.Read.All`, `Group.Read.All`).
- The script must run on Windows with PowerShell and .NET assemblies available.
- User must have access to the specified UNC paths.

## Configuration

Edit the following variables at the top of the script:

- `$clientId`: Azure AD Application (client) ID.
- `$tenantId`: Azure AD Tenant ID.
- `$redirectUri`: Redirect URI used in the app registration.
- `$dnsDomainName`: Internal DNS domain name.
- `$Drivemappings`: Array of drive mapping definitions. Each entry includes:
  - `includeSecurityGroup`: Azure AD group required for mapping.
  - `excludeSecurityGroup`: Azure AD group that, if present, prevents mapping.
  - `driveLetter`: Drive letter to assign.
  - `UNCPath`: Network path to map.

Example:
```powershell
$Drivemappings = @(
    @{"includeSecurityGroup" = "FOLDERPERM_FULL-ACCESS"; "excludeSecurityGroup" = ""; "driveLetter" = "T"; "UNCPath" = "\\skunklab.co.uk\dfs\shared"},
    @{"includeSecurityGroup" = "FOLDERPERM_ALL-STAFF"; "excludeSecurityGroup" = "FOLDERPERM_FULL-ACCESS"; "driveLetter" = "T"; "UNCPath" = "\\skunklab.co.uk\dfs\shared\sharedaccess"}
)
```

## Usage

1. Upload the script to an Azure Storage Account that is accessible to the client devices.
2. Update the configuration variables in the script as needed.
3. Deploy the script using Intune or another management tool, referencing the script's Azure Storage URL to ensure clients can download and execute it.
4. The script will prompt for Azure AD authentication, retrieve group memberships, and map drives accordingly.

## Logging

Execution is logged to:
```
C:\ProgramData\Intune-PowerShell-Logs\Set-WindowsMappedDrives-<timestamp>.log
```

## Notes

- Ensure the Azure AD application has the correct permissions and is consented by an admin.
- The script uses a GUI for authentication; ensure interactive logon is possible if running outside Intune.
- Drive mappings are persistent and global in scope.

## Author

Matt White

## License

MIT License (add your license details here if
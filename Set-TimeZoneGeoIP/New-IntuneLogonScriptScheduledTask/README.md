```markdown
# New-IntuneLogonScriptScheduledTask

The **New-IntuneLogonScriptScheduledTask** PowerShell script creates a Scheduled Task that runs at user logon to execute a PowerShell script hosted in an Azure Blob Storage account. This solution is useful for environments where a system-context script is needed to perform tasks such as updating configurations, applying policies, or setting environment parameters upon user logon.

## Script Overview

- **Log Initialization:**  
  The script begins by initializing a transcript log in the `%ProgramData%\Intune-PowerShell-Logs\` directory. This log captures details about the execution process for later troubleshooting.

- **Configuration Variables:**  
  The user is required to edit the following variables:
  - `$scriptLocation`: The URL pointing to the PowerShell script stored in an Azure Blob Storage account.
  - `$taskName`: A unique name for the scheduled task that will be created.

- **Scheduled Task Setup:**  
  The script constructs a command that downloads and executes the script from the specified Azure Blob Storage location. It then:
  - Checks if a scheduled task with the given name already exists.
  - If the task exists and its arguments match the desired configuration, it confirms its presence.
  - If the task exists with outdated parameters, it unregisters the existing one and creates a new scheduled task with the correct settings.
  - The task is configured to trigger at every user logon.

## Prerequisites

- **Administrative Permissions:**  
  The script must be executed with administrative privileges to create or modify scheduled tasks on the target machine.

- **Azure Blob Storage:**  
  Ensure that the PowerShell script referenced by `$scriptLocation` is correctly hosted in Azure Blob Storage and accessible to the target devices.

- **Intune Deployment:**  
  This script is intended for deployment via Microsoft Intune in a system context.

## Usage

1. **Edit the Script Variables:**  
   - Replace the placeholder in `$scriptLocation` with the actual URL of your PowerShell script hosted in Azure Blob Storage.
   - Set `$taskName` to your desired name for the scheduled task.

2. **Upload to Intune as a Platform Script:**  
   - Sign in to the Microsoft Intune admin center.
   - Navigate to **Devices** > **Windows** > **PowerShell scripts**.
   - Click **+ Add** to create a new PowerShell script deployment.
   - Provide a name and description for the script.
   - Upload the `New-IntuneLogonScriptScheduledTask.ps1` file.
   - Configure the script settings (e.g., run this script using the system context, run script in 64-bit PowerShell, etc.) according to your environment requirements.
   - Assign the script to the desired device groups to push it to your managed Windows devices.

3. **Deployment:**  
   Once the script is uploaded and assigned, it will run on the managed Windows devices during the next policy refresh or at user logon, creating or updating the scheduled task as defined.

## Output

- **Console Messages:**  
  The script outputs messages indicating the status of the scheduled task:
  - Confirmation if an existing task matches the expected configuration.
  - Status of deletion and creation processes if changes were necessary.

- **Log File:**  
  A transcript log is saved in `%ProgramData%\Intune-PowerShell-Logs\`, uniquely named based on the current date and time to help with troubleshooting.

## Example Output

```powershell
Task Exists and names match
```
or
```powershell
OldTask: <previous task details>
NewTask: <new task details>
Deleting Scheduled Task
Creating Scheduled Task
```

## Author

Authored by [@MattWhite-personal](https://github.com/MattWhite-personal).

## Reference

For further insights into similar deployment strategies, please refer to the blog post: [Mapping Legacy File Shares for Azure AD Joined Devices](https://matthewjwhite.co.uk/2019/04/07/mapping-legacy-files-shares-for-azure-ad-joined-devices/).

Happy scripting!

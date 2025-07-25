# Scripts Repository

Welcome to the **Scripts** repository! This collection is designed to serve the wider IT community by providing a variety of useful scripts, each aimed at simplifying, automating, or enhancing common IT tasks.

## Repository Structure

- Each script is organized into its own directory within the repository.
- Every script folder contains:
  - The script itself
  - An individual `README.md` file with a detailed description and usage instructions

This modular structure enables easy navigation, understanding, and collaboration for users and contributors alike.

## Script Index

| Script | Description | Blog Post |
|--------------|-------------|-------------|
| [Get-ADInactiveAccounts](./Get-ADInactiveAccounts/README.md) | Create a report on accounts in an on premises Active Directory forest that have not been used in a prescribed number of days | [Link](https://matthewjwhite.co.uk/2015/10/27/reporting-on-inactive-ad-user-accounts/)
| [Get-ADPasswordLastChanged](./Get-ADPasswordLastChanged/README.md) | Create a report on accounts and when their password was last rotated | [Link](https://matthewjwhite.co.uk/2015/10/27/reporting-on-ad-users-last-password-change/)
| [Get-EntraSCIMReport](./Get-EntraSCIMReport/README.md) | Create a report on Enterprise Applications in an Entra tenant that are configured for SCIM provisioning | [Link](https://matthewjwhite.co.uk/2025/07/12/entra-scim-report/)
| [New-IntuneLogonScriptScheduledTask](./New-IntuneLogonScriptScheduledTask/README.md) | Intune Platform script to install another script as a scheduled task to run at user logon. A *modern* approach to Group Policy login scripts | [Link](https://matthewjwhite.co.uk/2019/04/07/mapping-legacy-files-shares-for-azure-ad-joined-devices/)
| [Set-TimeZoneGeoIP](./Set-TimeZoneGeoIP/README.md) | Use Geo IP data to set the timezone on a Windows device | [Link](https://matthewjwhite.co.uk/2019/04/18/intune-automatically-set-timezone-on-new-device-build/)
| [Set-WindowsMappedDrives](./Set-WindowsMappedDrives/README.md) | A modern approach to replace logon scripts or Group Policy Processing for cloud native computers | [Link](https://matthewjwhite.co.uk/2019/04/07/mapping-legacy-files-shares-for-azure-ad-joined-devices/)

## Usage

1. **Browse the Repository:**  
   Explore the folders to discover scripts that may be useful for your needs.

2. **Read Script Documentation:**  
   Each script's folder contains a dedicated `README.md` file with:
   - Purpose and description
   - Setup instructions
   - Usage examples
   - Any dependencies or requirements

3. **Clone or Download:**  
   Clone the repository or download the specific script folder you need.

   ```bash
   git clone https://github.com/<your-username>/Scripts.git
   ```

4. **Run the Script:**  
   Follow the instructions provided in the individual script's `README.md`.

## Contributing

Contributions are welcome! To add a new script:
1. Create a new folder named after your script.
2. Add your script file(s).
3. Add a `README.md` describing the script, its purpose, usage, requirements, and examples.
4. Submit a pull request.

Please ensure your script is original, useful, and well-documented.

## License

This repository is licensed under the [MIT License](LICENSE).

## More from the Author

For more IT tips, scripts, and technical articles, visit my blog: [https://matthewjwhite.co.uk](https://matthewjwhite.co.uk)

---

Feel free to open issues or pull requests to suggest improvements or contribute new scripts!

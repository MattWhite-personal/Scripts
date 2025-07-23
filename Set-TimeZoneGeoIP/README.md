# Set-TimeZoneGeoIP

The **Set-TimeZoneGeoIP** PowerShell script is designed to automatically set the system's time zone based on the device's public IP address. It uses geo-location APIs to determine the correct time zone for the computer, ensuring that the system clock is correctly configured.

## Script Overview

The script performs the following steps:

1. **Log Initialization**  
   It creates a log file in the Intune-PowerShell-Logs directory to record the script activity.

2. **Geo-Location Retrieval**  
   - Uses the ipstack API to retrieve the public IP address along with the latitude, longitude, and country information.
   - In case of an error during this step, the script outputs an error message and exits.

3. **Time Zone Determination**  
   - Uses the Bing Maps API to determine the corresponding Windows time zone ID based on the geo-coordinates obtained.
   - If the Bing Maps API call fails, the script outputs an error message and exits.

4. **Time Zone Comparison and Setting**  
   - Compares the detected correct time zone with the current system time zone.
   - If the time zones do not match, it attempts to set the system's time zone to the correct one using the `Set-TimeZone` cmdlet.
   - Finally, it logs the new time zone setting.

5. **Transcript Logging**  
   The script records all steps in a transcript for audit and troubleshooting purposes.

## Prerequisites

- **API Keys:**  
  The script requires two API keys:
  - **ipstack API Key:** To obtain geo-coordinates based on the public IP. (Sign up at [ipstack](https://ipstack.com) for an API key.)
  - **Bing Maps API Key:** To retrieve the Windows time zone ID based on location coordinates. (Available from [Bing Maps](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/bingmaps.mapapis))

- **Administrative Permissions:**  
  The script must be run with sufficient permissions to change the system time zone and to access the necessary directories for log file creation.

## Usage

1. **Edit API Keys:**  
   Open the script in a text editor and replace the placeholder API key strings for `$ipStackAPIKey` and `$bingMapsAPIKey` with your actual keys.

2. **Run the Script:**  
   Open PowerShell with administrative privileges and execute the script:
   ```powershell
   .\Set-TimeZoneGeoIP.ps1
   ```

3. **Review Logs:**  
   The script will generate a transcript log in the directory specified by `$env:ProgramData\Intune-PowerShell-Logs` that details the process and any issues that were encountered.

## Output

- **Log File:**  
  A log file is created in the `ProgramData\Intune-PowerShell-Logs` directory with a unique name based on the current date and time.
- **Console Output:**  
  The script writes output messages to the console describing each major step, including the detected public IP, geo-location details, determined time zone, and the result of attempting to set the new time zone.

## Example Console Output

```powershell
Attempting to get coordinates from egress IP address
Detected that 203.0.113.45 is located in United States at 37.7749,-122.4194
Attempting to find Corresponding Time Zone
Detected Correct time zone as Pacific Standard Time, current time zone is set to Eastern Standard Time
Attempting to set timezone to Pacific Standard Time
Set Time Zone to: Pacific Standard Time
```

## Reference

For further details and background on how this script works, please refer to the blog post: [Intune Automatically Set Timezone on New Device Build](https://matthewjwhite.co.uk/2019/04/18/intune-automatically-set-timezone-on-new-device-build/).

## Author

Authored by [@MattWhite-personal](https://github.com/MattWhite-personal).

Happy scripting!

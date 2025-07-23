<#
    DESCRIPTION:    Create a Scheduled Task to run at User Login that executes
                    that executes a powershell script stored in an Azure blob storage account
    AUTHOR:         Matt White
    DATE:           2019-04-06
    USAGE:          Edit the values in the first section with respect to your link to the script
                    Add in the name of the scheduled task that you want to be called
                    Uplod the script to Intune to execute as a system context script

#>

<#
    DO NOT EDIT THIS SECTION
#>

$scriptName = ([System.IO.Path]::GetFileNameWithoutExtension($(Split-Path $script:MyInvocation.MyCommand.Path -Leaf)))
$logFile = "$env:ProgramData\Intune-PowerShell-Logs\$scriptName-" + $(Get-Date).ToFileTimeUtc() + ".log"
Start-Transcript -Path $LogFile -Append

<#
    END SECTION
#>

<#
    Setup Script Variables
#>

$scriptLocation = "https://#############.blob.core.windows.net/path-to/script-file.ps1" #enter the path to your script StorageAccounts->"account"->Blobs->"container"->"script"->URL
$taskName = "<<scheduled-task-name>>" #enter the name for your scheduled task

<#
    END SECTION
#>

<#
    Setup the Scheduled Task
#>


$schedTaskCommand = "Invoke-Expression ((New-Object Net.WebClient).DownloadString($([char]39)$($scriptLocation)$([char]39)))"
$schedTaskArgs= "-ExecutionPolicy Bypass -windowstyle hidden -command $($schedTaskCommand)"
$schedTaskExists = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
If (($schedTaskExists)-and (Get-ScheduledTask -TaskName $taskName).Actions.arguments -eq $schedTaskArgs){
    Write-Output "Task Exists and names match"
}
Else {
    if($schedTaskExists) {
        Write-Output "OldTask: $((Get-ScheduledTask -TaskName $taskName).Actions.arguments)"
        Write-Output "NewTask: $($schedTaskCommand)"
        Write-Output "Deleting Scheduled Task"
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
    }
    Write-Output "Creating Schdeuled Task"
    $schedTaskAction = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument $schedTaskArgs
    $schedTaskTrigger = New-ScheduledTaskTrigger -AtLogon
    $schedTaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Compatibility Win8
    $schedTaskPrincipal = New-ScheduledTaskPrincipal -GroupId S-1-5-32-545
    $schedTask = New-ScheduledTask -Action $schedTaskAction -Settings $schedTaskSettings -Trigger $schedTaskTrigger -Principal $schedTaskPrincipal -ErrorVariable $NewSchedTaskError
    Register-ScheduledTask -InputObject $schedTask -TaskName $taskName -ErrorVariable $RegSchedTaskError
}

Stop-Transcript

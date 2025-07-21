<#
    .SYNOPSIS
    This script generates a report of Entra ID Service Principals with their SCIM synchronization job status.
    .DESCRIPTION
    This script retrieves all Service Principals in Entra ID and checks if they have a SCIM synchronization job configured.
    .PARAMETER exportPath
    The path where the report will be exported as a CSV file.
    .PARAMETER reportAll
    If set to true, the report will include Service Principals that do not have SCIM synchronization jobs configured.
    .EXAMPLE
    .\Get-EntraIdServicePrincipalScimReport.ps1 -exportPath "C:\Reports\SCIMReport.csv" -reportAll $true
    Gets all Service Principals and generates a report including those without SCIM synchronization jobs, exporting it to the specified path.
    .EXAMPLE
    .\Get-EntraIdServicePrincipalScimReport.ps1 -exportPath "C:\Reports\SCIMReport.csv"
    Gets all Service Principals and generates a report only for those with SCIM synchronization jobs, exporting it to the specified path.

#>

param(
    [Parameter(Mandatory = $true)]
    [string]$exportPath,

    [Parameter(Mandatory = $false)]
    [bool]$reportAll = $false
)
# Ensure the Microsoft Graph PowerShell module is installed
try {
    Import-Module -Name Microsoft.Graph.Authentication, Microsoft.Graph.Applications -ErrorAction Stop
} catch {
    Write-Error "Microsoft Graph PowerShell module is not installed. Please install it using 'Install-Module Microsoft.Graph'."
    exit 1
}

# Connect to Microsoft Graph
try {
    Connect-MgGraph -Scopes "Synchronization.Read.All", "Application.Read.All"
} catch {
    Write-Error "Failed to connect to Microsoft Graph. Please ensure you have the necessary permissions."
    exit 1
}
# Check if the export path is valid
if (-not (Test-Path -Path (Split-Path -Path $exportPath -Parent))) {
    Write-Error "The specified export path does not exist: $exportPath"
    exit 1
}
# Initialize the report table
$reportTable = New-Object System.Data.DataTable
$reportTable.Columns.Add("ServicePrincipalId", [string]) | Out-Null
$reportTable.Columns.Add("ServicePrincipalDisplayName", [string]) | Out-Null
$reportTable.Columns.Add("Job", [string]) | Out-Null

# Get all Service Principals
try {
    $sps = Get-MgServicePrincipal -All | Sort-Object DisplayName -ErrorAction Stop
} catch {
    Write-Error "Failed to retrieve Service Principals. Please check your permissions."
    exit 1
}

# Check each Service Principal for SCIM synchronization jobs
foreach ($sp in $sps) {
    Write-Host "Checking Service Principal: $($sp.DisplayName) ($($sp.Id))"
    $job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $sp.Id -ErrorAction SilentlyContinue
    if ($job) {
        Write-Host "Found SCIM synchronization job for Service Principal: $($sp.DisplayName) ($($sp.Id))"
        $row = $reportTable.NewRow()
        $row.ServicePrincipalId = $sp.Id
        $row.ServicePrincipalDisplayName = $sp.DisplayName
        $row.Job = "SCIM is configured"
        $reportTable.Rows.Add($row)
    }
    else {
        Write-Host "No SCIM synchronization job found for Service Principal: $($sp.DisplayName) ($($sp.Id))"
        if ($reportAll) {
            $row = $reportTable.NewRow()
            $row.ServicePrincipalId = $sp.Id
            $row.ServicePrincipalDisplayName = $sp.DisplayName
            $row.Job = "SCIM is not configured"
            $reportTable.Rows.Add($row)
        }
    }
}

# Export the report to CSV
$reportTable | Export-Csv -NoTypeInformation -Path $exportPath

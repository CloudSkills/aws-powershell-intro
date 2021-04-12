<#
To use run next two lines in PowerShell:

curl -o $env:TMP/AwsPsPrompt.ps1 https://raw.githubusercontent.com/aws-samples/eks-powershell-shortcuts/main/src/AwsPsPrompt.ps1
. $env:TMP/AwsPsPrompt.ps1

Requires AWS Tools for PowerShell to be installed: https://www.powershellgallery.com/packages/AWSPowerShell.NetCore/

This scripts
1. Sets your PowerShell prompts to look like 
   "PS us-east-2@default C:\>"

2. Implements Set-AWSProfile and Set-AWSRegion commands keeping AWS CLI and AWS PowerShell Toolkit 
profiles and current region in sync. Lab boxes should have this script in there All Users/All Host PS profile 
(https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles)

You may run this script from you $PSHome/Profile.ps1 if you don't mind 7-8 second delay 
caused by the "Import-Module awspowershell.netcore", when opening PowerShell window.
#>

# $InformationPreference = "Continue"

Write-Host "Adding all AWS PowerShell commands. It may take a few seconds.."
Import-Module awspowershell.netcore

function Get-VarValue {
    param (
        [Parameter(mandatory=$true)] [string] $variableName
    )
    
    return $variableName ? (Get-Variable $variableName -ErrorAction SilentlyContinue).Value : $null
}

class AwsContext 
{
    [string] $AccountId
    [string] $AccessKey
    [string] $SecretKey
    [string] $Region
    [string] $Profile
    [bool] $WasCurrent

    AwsContext([string] $OptioinalProfileName) 
    {
        $this.Profile = $OptioinalProfileName ? $OptioinalProfileName : "default"
    }

    [void] SetCurrentRegion() {}
    [void] SetCurrentProfile() {}

    static [string] GetInstanceRegion() {
        return (Get-EC2InstanceMetadata -category Region).SystemName
    }
}

class SdkContext : AwsContext 
{
    SdkContext([string] $OptioinalProfileName) : base($OptioinalProfileName) 
    {
        [string] $currentProfile = [SdkContext]::GetCurrentProfile()
        $this.WasCurrent = $currentProfile -eq $this.Profile
        $this.Region = [SdkContext]::GetCurrentRegion()

        $credentials = $null

        if($this.WasCurrent) {
            $this.AccountId = (Get-STSCallerIdentity).Account
            $credObj = Get-AWSCredential
            $credentials = $credObj ? $credObj.GetCredentials() : $null
        }elseif ([SdkContext]::ProfileExists($currentProfile)) {
            $credentials = (Get-AWSCredential -ProfileName $currentProfile).GetCredentials()
        }

        if($credentials) {
            $this.AccessKey = $credentials.AccessKey
            $this.SecretKey = $credentials.SecretKey
        }
    }

    static [string] GetCurrentProfile() {
        return Get-VarValue "StoredAWSCredentials"
    }

    static [string] GetCurrentRegion() {
        return (Get-DefaultAWSRegion).Region
    }

    static [bool] ProfileExists([string] $profile) {
        return (Get-AWSCredential -ListProfileDetail | Where-Object {$_.ProfileName -eq $profile}).Count -gt 0
    }

    static [void] SetRegion([string] $region) 
    {
        Set-DefaultAWSRegion $region -Scope Global
    }

    static [void] SetProfile([string] $profileName) {
        [SdkContext]::SetProfile($profileName, $true)
    }

    static [void] SetProfile([string] $profileName, [bool] $setEverywhere) 
    {
        Set-AWSCredential -ProfileName $profileName -Scope Global # Sets surrent SDK/PS profile
    }

    [void] SetCurrentRegion() 
    {
        [SdkContext]::SetRegion($this.Region)
    }

    [void] SetCurrentProfile() 
    {
        [SdkContext]::SetProfile($this.Profile)
    }

    [void] SaveCredentialsAs([string] $profile) 
    {
        if($this.AccessKey -and $this.SecretKey) {
            Set-AWSCredential -AccessKey $this.AccessKey -SecretKey $this.SecretKey -StoreAs $profile
        }
    }
}

class CliContext : AwsContext {

    CliContext([string] $OptioinalProfileName) : base($OptioinalProfileName) 
    {
        [string] $currentProfile = [CliContext]::GetCurrentProfile()
        $this.WasCurrent = $currentProfile -eq $this.Profile

        if($this.WasCurrent) {
            $this.AccountId = [CliContext]::GetCurrentAccountId()
            $this.AccessKey = aws configure get aws_access_key_id
            $this.SecretKey = aws configure get aws_secret_access_key
            $this.Region = [CliContext]::GetCurrentRegion()
        } else {
            if([CliContext]::ProfileExists($OptioinalProfileName)) {
                $this.AccessKey = aws configure get aws_access_key_id --profile $this.Profile
                $this.SecretKey = aws configure get aws_secret_access_key --profile $this.Profile
                $this.Region = aws configure get region --profile $this.Profile
            }
        }
    }

    static [string] GetCurrentRegion() {
        return aws configure get region
    }

    static [string] GetCurrentProfile() {
        return $env:AWS_PROFILE
    }

    static [bool] ProfileExists([string] $profile) {
        return (aws configure list --profile $profile).Count -gt 3
    }

    static [string] GetCurrentAccountId() 
    {
        return (aws sts get-caller-identity | ConvertFrom-Json).Account
    }

    static [void] SetProfile([string] $profileName) {
        [CliContext]::SetProfile($profileName, $true) 
    }

    static [void] SetProfile([string] $profileName, [bool] $setEverywhere) 
    {
        $profileName = ($profileName -eq "default") ? "" : $profileName

        $env:AWS_PROFILE = $profileName
        if($setEverywhere) {
            [System.Environment]::SetEnvironmentVariable("AWS_PROFILE", $env:AWS_PROFILE, [System.EnvironmentVariableTarget]::User)            
        }
    }

    static [void] SetRegion([string] $region) 
    {
        if(-Not $region) { return }
        aws configure set region $region | Out-Host
    }

    [void] SetCurrentRegion() 
    {
        [CliContext]::SetRegion($this.Region)
    }

    [void] SetCurrentProfile() 
    {
        [CliContext]::SetProfile($this.Profile)
    }
}

function Get-CliContext([string] $optioinalProfileName) 
{
    return [CliContext]::new($optioinalProfileName)
}

function Get-SdkContext([string] $optioinalProfileName) 
{
    return [SdkContext]::new($optioinalProfileName)
}

function Set-AWSRegion {
    param ([Parameter(mandatory=$true)] [string] $region)

    [SdkContext]::SetRegion($region)
    [CliContext]::SetRegion($region)
}

function Set-AWSProfile {
    param ([Parameter(mandatory=$true)] [string] $profileName)

    [string] $sdkRegion = [SdkContext]::GetCurrentRegion()

    [string]$currentProfile

    # Set current credentials profile
    if([CliContext]::ProfileExists($profileName)) {
        $currentProfile = $profileName
        [CliContext]::SetProfile($profileName) # Note, this may change current Region as with AWS CLI, region is part of the profile, while with AWS PS, it is not.
    }

    if([SdkContext]::ProfileExists($profileName)) {
        [SdkContext]::SetProfile($profileName)
        if(-Not $currentProfile) {
            $currentProfile = $profileName
        }
    }

    # Set current region
    if($sdkRegion) {
        [CliContext]::SetRegion($sdkRegion)
    }else {
        $cliRegion = [CliContext]::GetCurrentRegion()
        if($cliRegion) {
            [SdkContext]::SetRegion($cliRegion)
        }else {
            $instanceRegion = (Get-EC2InstanceMetadata -category Region).SystemName
            if($instanceRegion) {
                Set-AWSRegion $instanceRegion
            }
        }
    }
}

function Get-AWSProfile {
    [string] $sdkProfile = [SdkContext]::GetCurrentProfile()
    if($sdkProfile) {
        return $sdkProfile
    }

    [string] $cliProfile = [CliContext]::GetCurrentProfile()
    if($cliProfile) {
        return $cliProfile
    }

    return "default"
}

function Sync-CurrentCliAndSdkContexts() {
    [string] $sdkProfile = Get-AWSProfile
    Set-AWSProfile $sdkProfile
}

Sync-CurrentCliAndSdkContexts

# Write-Information "CLI Context"
# Get-CliContext
# Write-Information "CLI Context for default profile"
# Get-CliContext "default"
# Write-Information "CLI Context for mpsa profile"
# Get-CliContext "mpsa"
# Write-Information "CLI Context for bogus profile"
# Get-CliContext "bogus"
# Write-Information "------------------------------"

function prompt 
{
    $savedLASTEXITCODE = $LASTEXITCODE

    $prompt = "PS"
	$needsAt = $false
    if ($null -ne $StoredAWSRegion) 
    { 
        $prompt += " $StoredAWSRegion" 
		$needsAt = $true
    }
    if ($null -ne $StoredAWSCredentials)
    {
		if($needsAt) {
			$prompt += "@"
		}
        $prompt += "$StoredAWSCredentials"
    }
    
    $prompt += " $($pwd.ProviderPath)>"

    $global:LASTEXITCODE = $savedLASTEXITCODE
    return $prompt
}
# Refer to docs: https://docs.aws.amazon.com/powershell/latest/userguide/pstools-welcome.html

# AWS related modules, includes those from sources other than AWS
Find-Module AWS*

# See module author
Find-Module AWS* | Select-Object Author,CompanyName, Name,Version, PublishedDate, Description | Out-GridView

# Three distinct packages you can use
# 1 Single large module supports all services, suitable for PowerShell 7+ (formerly DotNet Core)
Find-Module AWSPowerShell.NetCore

# 2 Modularized AWS modules for each service
Find-Module AWS.Tools* 

# 3 Single large module supports all services, suitable for PowerShell 5.1  (aka Windows PowerShell)
Find-Module AWSPowerShell




# What do I have installed? Note if you have multiple version of the same version
Get-Module AWS* -ListAvailable

# You can update modules that are installed
Update-Module -name AWSPowerShell.NetCore  
# Consider uninstaller earliser versions that remain
Uninstall-Module -MaximumVersion 4.1.5.0 -Name AWSPowerShell.NetCore

# Modules that are available typically load automatically when you use them
# But not AWSPowerShell.NetCore, it's too large.
# You must first run the Import-Module AWSPowerShell.NetCore

Import-Module AWSPowerShell.NetCore -Verbose #-Verbose param shows each step, interesting but slow!

# See modules loaded into session
Get-Module AWS* | Select *

# See Version
Get-AWSPowerShellVersion

#
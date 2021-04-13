# Refer to docs: https://docs.aws.amazon.com/powershell/latest/userguide/pstools-welcome.html

# AWS related modules, includes those from sources other than AWS
Find-Module AWS*

# See module info in a grid
Find-Module AWS* | Select-Object Author,CompanyName, Name,Version, PublishedDate, Description | Out-GridView

# The AWS Tools for PowerShell are available as the following three distinct packages:
# 1 Single large module supports all services, suitable for PowerShell 7+ (formerly DotNet Core)
# I'm using this and recommend it for learning
# It can be slow because it's a massive binary with thousands of cmdlets
Find-Module AWSPowerShell.NetCore

# 2 Modularized AWS modules for each service
# Recommended for production
# Only load the modules you want to use
Find-Module AWS.Tools* 

# 3 Single large module supports all services, backwards compatible for PowerShell 5.1  (aka Windows PowerShell)
# Only recommended for older Windows PCs
Find-Module AWSPowerShell




# What do I have installed? Note if you have multiple version of the same version
Get-Module AWS* -ListAvailable

# To install the module
# Install-Module -name AWSPowerShell.NetCore  


# You can update modules that are already installed
Update-Module -name AWSPowerShell.NetCore  
# Consider uninstaller earliser versions that remain
Uninstall-Module -MaximumVersion 4.1.5.0 -Name AWSPowerShell.NetCore

# Modules that are available typically load automatically when you use them
# But not AWSPowerShell.NetCore, it's too large.
# You must first run the Import-Module AWSPowerShell.NetCore
Import-Module AWSPowerShell.NetCore -Verbose #-Verbose param shows each step, interesting but slow!
# NOTE: The very useful AwsPsPrompt.ps1 script imports this module for you.
# refer: https://github.com/aws-samples/eks-powershell-shortcuts/blob/main/src/AwsPsPrompt.ps1

# See modules loaded into session
Get-Module AWS* | Select *

# See Version
Get-AWSPowerShellVersion
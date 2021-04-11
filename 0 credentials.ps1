# Connecting to your AWS account from PowerShell session on your workstation
# refer https://docs.aws.amazon.com/powershell/latest/userguide/specifying-your-aws-credentials.html

# Before using AWS PowerShell from your workstation, create a user in IAM that has sufficient rights 
# (e.g. AdministratorAccess, which is full rights to the account) 
# and create access keys for that user, recording the secret in a safe place

# See credential related commands
Get-Command *AWSCredential

# See existing credentials. note difference between NetSDKCredentialsFile and SharedCredentialsFile for security
# described here: https://docs.aws.amazon.com/powershell/latest/userguide/specifying-your-aws-credentials.html#credential-handling-in-aws-tools-for-powershell-core
# more reference here: https://docs.aws.amazon.com/credref/latest/refdocs/overview.html
Get-AWSCredential -ListProfileDetail

# Add a new credential
$myAccessKey = Read-Host -Prompt 'AWS Access Key?'
# AWS docs PowerShell examples have secret entered as clear text, let's make it a little more secure
$mySecret = Read-Host -Prompt 'AWS Secret?' -AsSecureString
$myProfileName = 'davetraining'
Set-AWSCredential -StoreAs $myProfileName -AccessKey $myAccessKey -SecretKey (ConvertFrom-SecureString $mySecret -AsPlainText)


# To make subsequent commands easier, recommended to set a default profile with default region
Initialize-AWSDefaultConfiguration -ProfileName $myProfileName -Region us-east-2

# See Identity
Get-STSCallerIdentity -Verbose

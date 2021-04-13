# Connecting to your AWS account from PowerShell session on your workstation
# refer https://docs.aws.amazon.com/powershell/latest/userguide/specifying-your-aws-credentials.html
# refer https://docs.aws.amazon.com/powershell/latest/reference/items/Common_cmdlets.html

# It is helpful to use the custom PowerShell prompt script from the AWS Samples repo
# It imports the AWS PowerShell module, and displays your profile and region in your prompt
# https://github.com/aws-samples/eks-powershell-shortcuts/blob/main/src/AwsPsPrompt.ps1

# Before using AWS PowerShell from your workstation, create a user in IAM that has sufficient rights 
# (e.g. AdministratorAccess, which is full rights to the account) 
# Create access keys for that user, recording the secret in a safe place

# See credential related commands
Get-Command *AWSCredential

# See existing credentials. note difference between NetSDKCredentialsFile and SharedCredentialsFile for security
# described here: https://docs.aws.amazon.com/powershell/latest/userguide/specifying-your-aws-credentials.html#credential-handling-in-aws-tools-for-powershell-core
# more reference here: https://docs.aws.amazon.com/credref/latest/refdocs/overview.html
Get-AWSCredential -ListProfileDetail

# Store a new credential on your workstation, you'll need the Access Key and Secret
# AWS docs PowerShell examples have secret entered as clear text, let's make it a little more secure
$myAccessKey = Read-Host -Prompt 'AWS Access Key?'
$mySecret = Read-Host -Prompt 'AWS Secret?' -AsSecureString
$myProfileName = 'davesandbox' # Useful profile name helps stay organized when you use multiple AWS accounts
Set-AWSCredential -StoreAs $myProfileName -AccessKey $myAccessKey -SecretKey (ConvertFrom-SecureString $mySecret -AsPlainText)

# View stored credentials
Get-AWSCredential -ListProfileDetail

# Make a profile the default profile, and set the default region for subsequent commands
Initialize-AWSDefaultConfiguration -ProfileName $myProfileName -Region us-east-2

# Can also set the profile for your session
Set-AWSCredential -ProfileName default

# See Identity ,and test your AWS access
Get-STSCallerIdentity -Verbose

# test access to your AWS account
Get-STSCallerIdentity
Get-S3Bucket


# Can remove credentials you no longer want stored
Remove-AWSCredentialProfile -ProfileName someprofile

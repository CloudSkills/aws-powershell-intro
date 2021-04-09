# See the current user context
Get-STSCallerIdentity


# Create a new access key for an existing user
# refer: https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-prereq.html
New-IAMAccessKey -UserName alice
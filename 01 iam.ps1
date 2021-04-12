# refer https://docs.aws.amazon.com/powershell/latest/reference/items/IdentityManagement_cmdlets.html


# See the current user context
Get-STSCallerIdentity


Get-IAMRole
Get-IAMRoleList
Get-IAMRolePolicy
Get-IAMRolePolicyList
Get-IAMRoleList


# Find commands to create a new IAM user
Get-Command New*User* -Module AWS*

# Check the docs
Get-Help New-IAMUser 
Get-Help New-IAMUser -Examples
Get-Help New-IAMUser -Full
Get-Help New-IAMUser -Online



New-IAMUser

# Create a new access key for an existing user
# refer: https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-prereq.html
New-IAMAccessKey -UserName testuser


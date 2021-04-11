# refer https://docs.aws.amazon.com/powershell/latest/reference/items/Common_cmdlets.html


# Commands that work with AWS Regions

# Review matching commands
Get-Command *Region

# See AWS Regions
GET-AWSRegion



# Set the default region for this shell session
Set-DefaultAWSRegion -Region us-east-2 
Get-DefaultAWSRegion


# Set response logging
Set-AWSResponseLogging -Level 

# Work with $AWSHistory
# refer https://docs.aws.amazon.com/powershell/latest/userguide/pstools-pipelines.html
# Commands to list AWS pricing


# Get-PLSService Gets price lists metadata for the AWS services that are available.
# Check the docs
Get-Command Get*Service
Get-Help Get-PLSService -Examples

# get all services, slow
$services = Get-PLSService -Region us-east-1 -Verbose
$services

# Get one service
$EC2service = Get-PLSService -Region us-east-1 -ServiceCode AmazonEC2 -Verbose
$EC2service | Select -ExpandProperty AttributeNames

# Get-PLSProduct lists the products available for a AWS Service

# Check the docs
Get-Help Get-PLSProduct 
Get-Help Get-PLSProduct -Examples

# Try an example
Get-PLSProduct -ServiceCode AmazonEC2 -Region us-east-1

# Command returns JSON, let's make it easier to work with.
# Convert that JSON to PowerShell objects
$EC2ProductsJSON = Get-PLSProduct -ServiceCode AmazonEC2 -Region us-east-2
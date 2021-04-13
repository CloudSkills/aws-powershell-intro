# Many AWS cmdlets  return JSON, PowerShell can help
# For example, AWS Price List Service
# refer https://docs.aws.amazon.com/powershell/latest/reference/items/Pricing_cmdlets.html


# Command returns JSON, let's make it easier to work with.
# Convert that JSON to PowerShell objects
$EC2ProductsJSON = Get-PLSProduct -ServiceCode AmazonEC2 -Region us-east-1 -Filter @{Type="TERM_MATCH";Field="instanceType";Value="t4g.micro"}
$EC2ProductsJSON

$EC2Products =  $EC2ProductsJSON | ConvertFrom-JSON

$EC2Products
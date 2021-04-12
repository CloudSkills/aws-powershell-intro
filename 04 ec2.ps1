# review instance types
Get-EC2InstanceType
# Show types in a grid
Get-EC2InstanceType | Select * | Out-GridView

# review keypairs
Get-Command *keypair* # -Module AWSPowerShell.NetCore

Get-EC2KeyPair

# review instances
Get-EC2Instance

# need to drill down into the Instance property
Get-EC2Instance | 
  Select-Object -ExpandProperty Instances |
    Select-Object *

# look at the security group
Get-EC2Instance | 
  Select-Object -ExpandProperty Instances |
    Select-Object -ExpandProperty SecurityGroups

# store it in a variable
$sg = Get-EC2Instance | 
Select-Object -ExpandProperty Instances |
  Select-Object -ExpandProperty SecurityGroups
$sg  

# find the security group commands
Get-Command get*securitygroup

# look at the security group
Get-EC2SecurityGroup -GroupName $sg.GroupName

# look at the IpPermissions
Get-EC2SecurityGroup -GroupName $sg.GroupName |
  Select-Object -ExpandProperty IpPermissions |
    Select-Object -ExpandProperty Ipv4Ranges

# Use docs example
# Note use of tags
(Get-Ec2Instance).Instances |
  Select InstanceType, @{Name="Servername";Expression={$_.tags |
    where key -eq "Name" |
      Select Value -Expand Value}}


# Launch a new EC2 instance

# review launch templates
Get-EC2Template -Verbose
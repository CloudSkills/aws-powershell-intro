# get all the commands in a gridview
$AWSCommands = Get-Command -Module AWSPowerShell.NetCore | Select *
$AWSCommands | Select Name, CommandType, Version | Out-GridView



# Inside the AWS shell session, discovered interesting local variables
GCI variable:
$AWSHistory | gm
$AWSHistory.Commands
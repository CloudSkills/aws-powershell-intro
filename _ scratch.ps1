# get all the commands in a gridview
$AWSCommands = Get-Command -Module AWSPowerShell.NetCore | Select *
$AWSCommands | Select Name, CommandType, Version | Out-GridView



# Inside the AWS shell session, discovered interesting local variables
GCI variable:
$AWSHistory | gm
$AWSHistory.Commands



# Snippet that shows how to page thru API results
$nextMarker = $null
Do
{
    $results = Get-IAMRoleList -MaxItem 3 -Marker $nextMarker
    $nextMarker = $AWSHistory.LastServiceResponse.Marker
    $results
    Read-Host
} while ($nextMarker -ne $null)
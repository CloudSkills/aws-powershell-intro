# NEED HELP?

# The best source for help with AWS PowerShell cmdlets is the documentation
# refer https://docs.aws.amazon.com/powershell/latest/reference/

# CAUTION! TAKE NOTE!

# Using Get-Help with AWS Cmdlets can have a long initial delay up to 2 minutes, and may time out.
# This is probably because the help file is large and takes time to load into memory.
# You might need to wait a long time, or kill and restart your PowerShell session!
# I recommend using Get-Help in a separate terminal window.

# Use Measure-Command to see how long each command takes
Measure-Command {Get-S3Bucket} #fast
# BE READY TO WAIT...
Measure-Command {Get-Help Get-S3Bucket} #first time is SLOW, over 100 seconds on my machine
# ...This will be fast!
Measure-Command {Get-Help Get-S3Bucket} #second time help is loaded into memory, much faster


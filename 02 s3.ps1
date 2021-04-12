# Refer https://docs.aws.amazon.com/powershell/latest/reference/items/S3_cmdlets.html

# review S3 commands
Get-Command *-S3*

# list S3 buckets
Get-S3Bucket

# Look at how to create a S3 bucket
Get-Help New-S3Bucket -Examples
Get-Help New-S3Bucket -Online

# Create a S3 bucket with public read
New-S3Bucket
# Create a text file
Set-Content -Path $env:TEMP\testfile.txt -Value "Hello from PowerShell!"
Get-Content -Path $env:TEMP\testfile.txt 

# Write file to bucket
Get-Command *S3Object
Get-Command Write*s3*

Get-Help Write-S3Object -Examples
Get-Help Write-S3Object -Online

# write text file to S3
Write-S3Object -BucketName davepublicread -Key testfile.txt -File $env:TEMP\testfile.txt

Get-S3Object -BucketName davepublicread -Key testfile.txt -Verbose | Select * 

Get-S3ObjectMetadata -BucketName davepublicread -Key testfile.txt -Verbose | 
  Select -ExpandProperty Metadata |
    Select *

Read-S3Object -BucketName davepublicread -Key testfile.txt -File $env:TEMP\testfileresult.txt
Get-Content -Path $env:TEMP\testfileresult.txt 
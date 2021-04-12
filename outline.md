* Abstract
  > We'll begin from first login to AWS Cloud Shell, discovering the pwsh shell, AWS PowerShell modules, command syntax, common command features and shortcuts, and how PowerShell increases your understanding and ability to build confidently in the cloud.
* Intro
* Goal
  * Equip you to get started with PowerShell in AWS, over the beginners's hump
  * Inspire you to build an 'exploration script' to learn and solve a small problem in your AWS environment.
* Background
  * Warning: Geek Speak Ahead!
  * Talk uses PowerShell, will link to resources how to learn more about it
  * Talk uses AWS, requires some basic AWS knowledge to keep up
    * If you've used AWS console or SDKs you'll recognize the building blocks

 * Slide, or PAGE
* Background
* Big Picture
  * Cloud Providers
  * APIS
    * Ex [S3](https://docs.aws.amazon.com/AmazonS3/latest/API/API_Operations.html), [VPC](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/OperationList-query-vpc.html), [EC2](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/OperationList-query-ec2.html)
  * [SDKs & Tools](https://aws.amazon.com/getting-started/tools-sdks/)
    * [PowerShell](https://aws.amazon.com/powershell/) is one of these tools for working with AWS, and our focus today
* Terminology
  * PowerShell, the shell (run pwsh)
    * Compare to bash
  * PowerShell modules (e.g. AWS)
* Jump into AWS Cloud Shell
  * Concept diagram (Browser in AWS Console, opens container running shell (bash/pwsh), run commands from shell running inside a container)
  * Skip installation!
  * Basic commands & Config
* Set up AWS PowerShell on your machine  
  * Requirements
    * PowerShell (Latest 7 version recommended, works with Windows PowerShell 5.1 + .Net Framework 4.7.2)
      * Cross platform, supports Windows, Mac or Linux
    * Recommend Visual Studio Code for exploration and scripting  
  * Installing ([docs](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html))
    * 3 Flavors
      * AWS.Tools - The modularized version of AWS Tools for PowerShell. Each AWS service is supported by its own individual, small module, with shared support modules AWS.Tools.Common and AWS.Tools.Installer.
      * AWSPowerShell.NetCore - The single, large-module version of AWS Tools for PowerShell. All AWS services are supported by this single, large module.
        * My recommended approach for most scenarios, can add a few seconds of spinup time though..
      * AWSPowerShell - The legacy Windows-specific, single, large-module version of AWS Tools for PowerShell. All AWS services are supported by this single, large module.
        * REQUIRES .NET Framework 4.7.2 or newer is required.


* Connecting to AWS using your Credentials
  * *-AWSCredential
  * Cloud Shell lets me skip this step!
  * Credential Store Locations 

* Common Parameters
  * Verbose - See the API call made by a command
    * Ex. `Get-STSCallerIdentity -Verbose`

* Looking at objects
  * Types are from SDK for .Net


* Cautions
  * Each service has different levels of support for PowerShell features
    * Some have no built in help, some do
    * Some return JSON instead of PowerShell objects
  

* Learning scripts
  * Here's how I learn, take this idea and learn the parts that are useful to you!

* Demo Ideas
  * S3
  * EC2
  * VPC
  * Deploy Lambda function, see https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/blank-powershell
  * AwsPsPrompt see https://github.com/aws-samples/eks-powershell-shortcuts/blob/main/src/AwsPsPrompt.ps1


* Future Projects
 * AWS PowerShell STS tutorial
* Mix with AWSCLI
  * Dealing with JSON

```ps

      Install-Module -name AWSPowerShell.NetCore

```

    * AWSPowerShell - The legacy Windows-specific, single, large-module version of AWS Tools for PowerShell. All AWS services are supported by this single, large module.
* Starting points
  * Study... or Play?
  * Building Blocks
    * S3
    * VPC
    * EC2
  * First Projects
    * Inventory
    * Audit
    * CloudFormation
  * Play
  * Tricky Parts
    * JSON
    * JQ
    * IDs
* [Resources](./resources.md)
  
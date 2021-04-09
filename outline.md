* Abstract
  > In this beginner-level session, David Cobb will start from first login to AWS Cloud Shell, AWS PowerShell modules, command syntax, common features and shortcuts, and how PowerShell increases your understanding and ability to build confidently in the cloud.
* Intro
* Background
* Terminology
  * PowerShell, the shell (run pwsh)
    * Compare to bash
  * PowerShell modules (e.g. AWS)
* Jump into AWS Cloud Shell
* Basics
* Installing ([docs](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html))
  * 3 Flavors
    * AWS.Tools - The modularized version of AWS Tools for PowerShell. Each AWS service is supported by its own individual, small module, with shared support modules AWS.Tools.Common and AWS.Tools.Installer.

    * AWSPowerShell.NetCore - The single, large-module version of AWS Tools for PowerShell. All AWS services are supported by this single, large module.
      * My recommended approach for most scenarios, can add a few seconds of spinup time though..

    * AWSPowerShell - The legacy Windows-specific, single, large-module version of AWS Tools for PowerShell. All AWS services are supported by this single, large module.
      * REQUIRES .NET Framework 4.7.2 or newer is required.

* Connecting
  * *-AWSCredential
  * Cloud Shell lets me skip this step!


* Looking at objects
  * Types are from SDK for .Net

* Demo Ideas
  * S3
  * EC2
  * VPC
  * Deploy Lambda function, see https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/blank-powershell
  * AwsPsPrompt see https://github.com/aws-samples/eks-powershell-shortcuts/blob/main/src/AwsPsPrompt.ps1


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
  
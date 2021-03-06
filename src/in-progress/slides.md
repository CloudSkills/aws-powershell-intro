---
title: Take Command of AWS PowerShell
description: We'll begin from first login to AWS Cloud Shell, discovering the pwsh shell, AWS PowerShell modules, command syntax, common command features and shortcuts, and how PowerShell increases your understanding and ability to build confidently in the cloud.
paginate: true
marp: true
theme: uncover
class: invert

body {
  text-align: left;
}
section.center {
  text-align: center;
}
---
<!-- _class: center -->
# Take Command of 
<!-- ![bg](http://url-to-file) -->
## AWS PowerShell <!-- fit -->
 ---
<!--# new slide
![bg right](https://picsum.photos/720?image=29)
![bg](https://picsum.photos/720?image=20)
- one
- two
- three
___ -->

## David Cobb
![bg right](https://www.davidcobb.net/wp-content/uploads/2021/04/David_2020-02_SW.jpg)
### Cloud consultant, instructor, learner
### Focus on Azure but supporting AWS as well
### [davidcobb.net](https://www.davidcobb.net)
### [@dave000777](https://twitter.com/dave000777)
___

# Goals for this talk
  ## Equip you to get started with PowerShell in AWS, and make it through the beginners's valley of discouragement.
  ## Share my exploration scripts for reference and inspiration.
  ## Inspire you to build an 'exploration script' to learn and solve a small problem in your AWS environment.
___

# Geek Alert!

## Working with AWS PowerShell involves working with multiple technologies & tools. 

## AWS, API, Terminal, shell, PowerShell, AWS PowerShell Module, Visual Studio Code, git.

## In the short time we have I'll introduce these, and help equip you to learn on your own.
___

# THE API

* Every action in AWS is done through the API

* To understand AWS we need to learn the API

* Console, SDKs, Tools including PowerShell Modules call this API

* They make AWS easier to learn and work in
___

* To use the AWS Console we need to have an AWS account, and a user with access to that account

* To use the API from PowerShell, tools or SDKs, we need a sign-in credential for that user, which requires an access key & secret
___
# Thank You!

## Q & A
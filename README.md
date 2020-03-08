Some musings and play with Salesforce Apex
-------------------------------------------

Apex is a programming language that is specific to Salesforce, it resembles an OO language like Java but lacks certain features such as reflection and dynamic runtime environment (such as lambdas etc). Having written a similar framework in .Net I can appreciate why the language has the restrictions it does; essentially you don't want a bad piece of code to bring down an entire service.

The code here are just musings, getting to know the language and some fun play!

The development environment is based around Salesforce DX, code is written locally and deployed to a Salesforce Org instance. The editor I use is Visual Studio Code, it's fast, simple to use and lightweight.

## Pre-requisites
- [Code Editor](https://code.visualstudio.com/download)
- [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli)
- [Salesforce Developer Hub](https://developer.salesforce.com/promotions/orgs/dx-signup)

## Getting started
Create a scratch org using scripts from root ./scripts/create-scratch-org.sh
Push source code using scripts from root ./scripts/push-source-code.sh
Open the scratch org instance in a browser with `sfdx force:org:open -u apex-playground`

## Code
[SOQL Builder using the Visitor pattern](force-app/main/default/classes/Soql/YetAnotherBuilder/Readme.md)

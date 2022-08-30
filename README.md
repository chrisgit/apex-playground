Some musings and play with Salesforce Apex
-------------------------------------------

[Apex is a programming language] that is specific to Salesforce, it resembles an OO language like Java but lacks certain features such as reflection and dynamic runtime environment (such as lambdas etc). Having written a similar framework in .Net I can appreciate why the language has the restrictions it does; essentially you don't want a bad piece of code to bring down an entire service.

The code represented in this repository are simply a collection of experiments to get to know the language and have a bit of fun at the same time.

The development environment is based around Salesforce DX, code is written locally and deployed to a Salesforce Org instance. The editor I use is Visual Studio Code, it's fast, simple to use and lightweight.

## Pre-requisites
- [Code Editor](https://code.visualstudio.com/download)
- [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli)
- [Salesforce Developer Hub](https://developer.salesforce.com/promotions/orgs/dx-signup)

## Getting started
Create a scratch org using scripts from root ./scripts/create-scratch-org.sh
Push source code using scripts from root ./scripts/push-source-code.sh
Open the scratch org instance in a browser with `sfdx force:org:open -u apex-playground`

## General Development
[Running Anonymous Apex](force-app/main/default/classes/Developing/AnonymousApex.md) and [Developer Console](force-app/main/default/classes/Developing/DeveloperConsole.md)

## Code in this repository
[Dealing with Objects](force-app/main/default/classes/Objects/Readme.md) and [sObjects](force-app/main/default/classes/sObjects/Readme.md)

[Object Oriented Play](force-app/main/default/classes/OOP/Readme.md)

[SOQL Builder using the Visitor pattern](soql-builder/main/default/classes/YetAnotherBuilder/Readme.md)

[LINQ like querying](force-app/main/default/classes/LocalQuery/Readme.md)

[Test Data Builder](force-app/main/default/classes/TestData/Readme.md)

[Some of the quirks associated with Apex](force-app/main/default/classes/Quirks/Readme.md)

[Postman Examples](postman/Readme.md)

[Apex is a programming language]: ApexLanguage.md

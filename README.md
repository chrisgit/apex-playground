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
[Running Anonymous Apex](docs/developing/anonymous-apex.md) and [Developer Console](docs/developing/developer-console.md)

## Code in this repository
[Dealing with Objects](docs/apex-objects.md) and [sObjects](docs/apex-sobjects.md)

[Object Oriented Play](docs/object-orientated-programming.md)

[SOQL Builder using the Visitor pattern](docs/yet-another-soql-builder.md)

[LINQ like querying](docs/linq-like-querying.md)

[Test Data Builder](docs/test-data-builder.md)

[Http Helpers](docs/http-helpers.md)

[Custom REST api](docs/custom-rest-api.md)

[Some of the quirks associated with Apex](docs/quirks.md)

[Postman Examples](postman/readme.md)

[Apex is a programming language]: apex-language.md

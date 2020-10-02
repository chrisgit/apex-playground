Postman
-------

[Postman] is a must have tool for calling or testing your API. The product has moved on a from being a GUI version of [cURL] to something that can 
- Automate Testing
- Design and Mock
- Monitor services
- Generate and publish documentation 

At it's core Postman's primary purpose is to make calls to your API and it does this well, showing responses details in a well laid out UI, additionally it can
- build and store a collection of URL calls
- format responses
- test responses and validate the shape of the data
- create collections from other API tools such as Swagger/OpenAPI

An interesting aspect of Postman is that you can add scripts and use variables to apply to the pre and post requests. The Postman team have even suggested that you can use postman for API testing which is made even more possible with the advent of [Newman] and the [Postman collection JavaScript library] that can be used in [Nodejs]. The Postman team have related the pre-request, request and respose to the triple A (arrange, act, assert) unit test analogy to facilitate adoption.

Postman remains one of my primary tools when dealing with Salesforce API (or custom API's), hence some basic examples here.

Alternative tools that I have used for calling or testing API's
- [Insomnia]
- [karate]
- [Dredd]

triple A (arange, act, assert)

[Postman]: https://www.postman.com/
[cURL]: https://curl.haxx.se/
[Newman]: https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/
[Postman collection JavaScript library]: https://www.npmjs.com/package/postman-collection
[Nodejs]: https://nodejs.org/en/
[Insomnia]: https://insomnia.rest/
[karate]: https://github.com/intuit/karate
[Dredd]: https://dredd.org/en/latest/
Metadata, Reflection and Dynamic Coding
---------------------------------------

### sObjects
The native object in Salesforce is an SObject, these objects contain data that can be sent or retrieved from a backend database.

The sObject maps to a logic or physical (it is unclear from the documentation) entities in the backend database and is similar in approach to an object relational mapping (ORM) framework in other languages. An sObject variable represents a row of data.

Using sObjects it is very easy to perform CRUD and Salesforce provide two data manipulation (DML) mechanisms for accessing and retrieving sObjects
- Salesforce Object Query Language (SOQL) 
- Salesforce Object Search Language (SOSL)

SOQL resembles SQL but is very much a subset of that language.

There is also a specialised form of SOQL for Big Objects (tables that exceed millions of records) as well as Async SOQL.

Using the object model is intuitive if you have used any ORM before.
To create a new Account row you can simple create a new instance of the Account sObject
```Apex
Account acc = new Account();
```

You can create an specific sObject and downcast it to the base sObject type
```Apex
sObject genericSObject = new Account();
Account acc = (Account)genericSObject;
// However cannot be cast to an illegal type
Contact cnt = (Contact)genericSObject;
```

When creating a new instance of an SObject you can specify initial field values with comma-separated name = value pairs.
```Apex
Account a = new Account(name = 'Acme', billingcity = 'San Francisco');
```

*Note:* The ID of an sObject is a read-only value and can never be modified explicitly in Apex unless it is cleared during a clone operation, or is assigned with a constructor.

SObject fields can be accessed or changed with simple dot notation.
```Apex
Account acc = new Account();
acc.Name = 'Acme';    // Access the account name field and assign it 'Acme'
```

*Note:* To erase the current value of a field, set the field to null.

SObject fields can be initially set or not set (unset); unset fields are not the same as null or blank fields. When you perform a DML operation on an SObject, you can change a field that is set; you can’t change unset fields. This is an important concept to understand and will affect calls to certain inbuilt functions such as the sObject class method getPopulatedFieldsAsMap().

If an Apex method takes an SObject parameter, you can use the System.isSet(field) method to identify the set fields. If you want to unset any fields to retain their values, first create an SObject instance. Then apply only the fields you want to be part of the DML operation.

This example code shows how SObject fields are identified as set or unset.
```Apex
Contact contactWithNullFirstName = new Contact(LastName='Codey', FirstName=null);
System.assertEquals(true, contactWithNullFirstName.isSet('FirstName'), 'FirstName is set to a literal value, so it counts as set');
Contact contactUnsetFirstName = new Contact(LastName='Astro');
System.assertEquals(false, contactUnsetFirstName.isSet('FirstName'), ‘FirstName is not set’);
```

An expression with sObject fields of type Boolean evaluates to true only if the sObject field is true. If the field is false or null, the expression evaluates to false. This example code shows an expression that checks if the IsActive field of a Campaign object is null. Because this expression always evaluates to false, the code in the if statement is never executed.

```Apex
Campaign camp = new Campaign(); 
...
   if (camp.IsActive == null) {
  ... // IsActive is evaluated to false and this code block is not executed.
   }
```

### Dynamic creation of objects
The [DynamicSObjectTests](DynamicSObjectTests) has examples of getting and setting fields on sObjects as well as creating sObjects.

### sObject Metadata
Each sObject has a rich set of metadata that can be interrogated to further describe the object and its relationship to other objects.

The [SObjectFieldMetadata.cls](SObjectFieldMetadata.cls) has examples of how to obtain information about fields.
The [SObjectRelationshipMetadata.cls](SObjectRelationshipMetadata.cls) has examples of how to obtain information about relationships.

### Navigating the sObjects
The [SObjectHelper.cls](SObjectHelper.cls) is a basic helper to descend an sObject in order to get related field values.

### References
[Dynamic Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic.htm)
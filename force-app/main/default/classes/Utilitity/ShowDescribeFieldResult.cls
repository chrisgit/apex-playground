// Schema.SObjectField f = Account.Contact.Name;
// Schema.DescribeFieldResult fr = f.getDescribe();
// System.Debug(fr.getDefaultValue())
// System.Debug(fr.)
// System.Debug(fr.)
// System.Debug(fr.)
// System.Debug(fr.)
// Schema.sObjectField ft = fr.getSObjectField();
// System.Debug(fr);
// System.Debug(ft);

// Try and get all of the fields using Type
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_type.htm

// new SObjectFieldMetaData class ... .dump() method?
// new class with static Debug.output(x, y); or Debug.show(x, y); or Debug.display(x, y); ... maybe not even have a class for this

public inherited sharing class ShowDescribeFieldResult {
    public ShowDescribeFieldResult() {

    }

    // Pass in Account.Contact.Name
    public static void displayFor(Schema.SObjectField field) {
        Schema.DescribeFieldResult fieldResult = field.getDescribe();
        showFor('getByteLength()', fieldResult.getByteLength());
        showFor('getCalculatedFormula()', fieldResult.getCalculatedFormula());
        showFor('getController()', fieldResult.getController());
        showFor('getDefaultValue()', fieldResult.getDefaultValue());
        showFor('getDefaultValueFormula()', fieldResult.getDefaultValueFormula());
        showFor('getDigits()', fieldResult.getDigits());
    }

    private static void showFor(String text, Object value) {
        String formatted = string.format('{0} has value of {1}', new string[] { text, String.valueOf(value) });
        System.Debug(formatted);
    }
}

/*
Returns the maximum number of digits specified for the field. This method is only valid with Integer fields.
getInlineHelpText()
Returns the content of the field-level help.
getLabel()
Returns the text label that is displayed next to the field in the Salesforce user interface. This label can be localized.
getLength()
Returns the maximum size of the field for the DescribeFieldResult object in Unicode characters (not bytes).
getLocalName()
Returns the name of the field, similar to the getName method. However, if the field is part of the current namespace, the namespace portion of the name is omitted.
getName()
Returns the field name used in Apex.
getPicklistValues()
Returns a list of PicklistEntry objects. A runtime error is returned if the field is not a picklist.
getPrecision()
For fields of type Double, returns the maximum number of digits that can be stored, including all numbers to the left and to the right of the decimal point (but excluding the decimal point character).
getReferenceTargetField()
Returns the name of the custom field on the parent standard or custom object whose values are matched against the values of the child external object's indirect lookup relationship field. The match is done to determine which records are related to each other.
getReferenceTo()
Returns a list of Schema.sObjectType objects for the parent objects of this field. If the isNamePointing method returns true, there is more than one entry in the list, otherwise there is only one.
getRelationshipName()
Returns the name of the relationship.
getRelationshipOrder()
Returns 1 if the field is a child, 0 otherwise.
getScale()
For fields of type Double, returns the number of digits to the right of the decimal point. Any extra digits to the right of the decimal point are truncated.
getSOAPType()
Returns one of the SoapType enum values, depending on the type of field.
getSObjectField()
Returns the token for this field.
getType()
Returns one of the DisplayType enum values, depending on the type of field.
isAccessible()
Returns true if the current user can see this field, false otherwise.
isAiPredictionField() (Beta)
Returns true if the current field is enabled to display Einstein prediction data, false otherwise.
isAutoNumber()
Returns true if the field is an Auto Number field, false otherwise.
isCalculated()
Returns true if the field is a custom formula field, false otherwise. Note that custom formula fields are always read-only.
isCascadeDelete()
Returns true if the child object is deleted when the parent object is deleted, false otherwise.
isCaseSensitive()
Returns true if the field is case sensitive, false otherwise.
isCreateable()
Returns true if the field can be created by the current user, false otherwise.
isCustom()
Returns true if the field is a custom field, false if it is a standard field, such as Name.
isDefaultedOnCreate()
Returns true if the field receives a default value when created, false otherwise.
isDependentPicklist()
Returns true if the picklist is a dependent picklist, false otherwise.
isDeprecatedAndHidden()
Reserved for future use.
isExternalID()
Returns true if the field is used as an external ID, false otherwise.
isFilterable()
Returns true if the field can be used as part of the filter criteria of a WHERE statement, false otherwise.
isFormulaTreatNullNumberAsZero()
Returns true if null is treated as zero in a formula field, false otherwise.
isGroupable()
Returns true if the field can be included in the GROUP BY clause of a SOQL query, false otherwise. This method is only available for Apex classes and triggers saved using API version 18.0 and higher.
isHtmlFormatted()
Returns true if the field has been formatted for HTML and should be encoded for display in HTML, false otherwise. One example of a field that returns true for this method is a hyperlink custom formula field. Another example is a custom formula field that has an IMAGE text function.
isIdLookup()
Returns true if the field can be used to specify a record in an upsert method, false otherwise.
isNameField()
Returns true if the field is a name field, false otherwise.
isNamePointing()
Returns true if the field can have multiple types of objects as parents. For example, a task can have both the Contact/Lead ID (WhoId) field and the Opportunity/Account ID (WhatId) field return true for this method. because either of those objects can be the parent of a particular task record. This method returns false otherwise.
isNillable()
Returns true if the field is nillable, false otherwise. A nillable field can have empty content. A non-nillable field must have a value for the object to be created or saved.
isPermissionable()
Returns true if field permissions can be specified for the field, false otherwise.
isRestrictedDelete()
Returns true if the parent object can't be deleted because it is referenced by a child object, false otherwise.
isRestrictedPicklist()
Returns true if the field is a restricted picklist, false otherwise
isSearchPrefilterable()
Returns true if a foreign key can be included in prefiltering when used in a SOSL WHERE clause, false otherwise.
isSortable()
Returns true if a query can sort on the field, false otherwise
isUnique()
Returns true if the value for the field must be unique, false otherwise
isUpdateable()
Returns true if the field can be edited by the current user, or child records in a master-detail relationship field on a custom object can be reparented to different parent records; false otherwise.
isWriteRequiresMasterRead()
Returns true if writing to the detail object requires read sharing instead of read/write sharing of the parent.
*/
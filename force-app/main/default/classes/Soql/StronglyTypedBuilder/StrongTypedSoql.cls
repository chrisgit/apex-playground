// StrongTypedSoql x = new StrongTypedSoql(Opportunity.sObjectType);
// x.addField(Opportunity.AccountId).addField(Opportunity.Name);
// System.debug(x.Build());

// For complex queries would need to embed Soql inside of Soql, i.e.
// select id, Name, (Select Id, Name from contacts), (Select Id, Name From Opportunities where Id='Your Opportunity Id') from Account
// However we can't seem to generate SOQL like this 
// StrongTypedSoql y = new StrongTypedSoql(Account.sObjectType);
// y.addField(Account.Name)
//     .addField(Account.Contact.Name)
//     .addField(Account.Contact.Id);
// System.debug(y.Build());
// Bacuse the Account.Contact.Name returns FieldDescription which contains the word name, can't seem to link it back to Contact

// Can we build ... SELECT Name, spapi__API_ID__c, API_ID__c, fHCM2__Department__r.Name, fHCM2__Current_Employment__r.fHCM2__Start_Date__c, fHCM2__Current_Employment__r.fHCM2__Work_Location__r.Name FROM fHCM2__Team_Member__c
// StrongTypedSoql x = new StrongTypedSoql(fHCM2__Team_Member__c.sObjectType);
// x.addField(fHCM2__Team_Member__c.Name)
//     	.addField(fHCM2__Team_Member__c.API_ID__c)
//     	.addField(fHCM2__Team_Member__c.spapi__API_ID__c)
//     	.addFieldSet(SObjectType.fHCM2__Team_Member__c.FieldSets.spapi__Employee_API_Additional_Fields);
// System.debug(x.Build());// Our current builder automatically adds spapi to fields

// Dynamic DML: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_dml.htm#sObjectCreationSectionTitle

// ObjectUtil.Map(Object or ObjectList, somefunction);
// ObjectUtil.Reduce(Object or ObjectList, filter or filters);

// Get all parent/children: https://salesforce.stackexchange.com/questions/117050/get-all-parent-and-child-objects-related-to-the-current-object

public with sharing class StrongTypedSoql {
    private Schema.SObjectType type;
    private List<Schema.SObjectField> fieldList = new List<Schema.SObjectField>();
    private List<Schema.FieldSet> fieldSetList = new List<Schema.FieldSet>();

    public StrongTypedSoql(Schema.SObjectType type) {
        this.type = type;
    }

    // Or accept a list of fields?
    public StrongTypedSoql addField(Schema.SObjectField field) {
        this.fieldList.add(field);
        return this;
    }

    public StrongTypedSoql addFieldSet(Schema.FieldSet fieldSet) {
        this.fieldSetList.add(fieldSet);
        return this;
    }

    public string Build() {
        // SObjectType.Account.FieldSets.accountFieldSet.getFields()
        // SObjectType.fHCM2__Team_Member__c.FieldSets.spapi__Employee_API_Additional_Fields
        List<string> stringFields = new List<string>();
	    for(SObjectField field : fieldList)	{
            stringFields.add(field.getDescribe().getName());
        }
        string soql = 'SELECT ' + string.join(stringFields, ',') + ' FROM ' + type.getDescribe().getName();
        for(FieldSet fieldSet : fieldSetList) {
            List<Schema.FieldSetMember> members = fieldSet.getFields();
            for(FieldSetMember fsm : members) {
                stringFields.add(fsm.getFieldPath());
            }
        }
        return string.join(stringFields, ',');
        //return soql;
    }
}

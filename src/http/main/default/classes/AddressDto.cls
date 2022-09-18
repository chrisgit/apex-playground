public with sharing class AddressDto {
    public string ObjectId;
    public string HouseNumberOrName;
    public string AddressLine1;
    public string AddressLine2;
    public string TownOrCity;
    public string County;
    public string PostCode;

    public AddressDto(Address_Change_Event__e evt) {
        ObjectId = evt.ObjectId__c;
        HouseNumberOrName = evt.HouseNumberOrName__c;
        AddressLine1 = evt.AddressLine1__c;
        AddressLine2 = evt.AddressLine2__c;
        TownOrCity = evt.TownOrCity__c;
        County = evt.County__c;
        PostCode = evt.PostCode__c;
    }
}

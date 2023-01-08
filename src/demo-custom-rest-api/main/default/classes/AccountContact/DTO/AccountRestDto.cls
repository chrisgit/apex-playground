public with sharing class AccountRestDto {
    public string id;
    public string accountNumber;
    public string accountName;
    public string industry;
    public List<ContactRestDto> contacts;

    public Boolean hasAccountId() {
        return id != null ? true : false;
    }

    public Boolean hasContacts() {
        return contacts == null || contacts.isEmpty() ? false : true;
    }
}

public class ContactRestDto {
    public string id;
    public string forename;
    public string surname;
    public string mobileNumber;
    public string homeNumber;
    public string email;

    public static Contact toSObject(ContactRestDto cntDto) {
        return new Contact(
            FirstName = cntDto.forename,
            LastName = cntDto.surname,
            HomePhone = cntDto.homeNumber,
            MobilePhone = cntDto.mobileNumber,
            Email = cntDto.email
        );
    }

    public static ContactRestDto toDto(Contact cnt) {
        ContactRestDto cntDto = new ContactRestDto();
        cntDto.id = cnt.Id;
        cntDto.forename = cnt.FirstName;
        cntDto.surname = cnt.LastName;
        cntDto.homeNumber = cnt.HomePhone;
        cntDto.mobileNumber = cnt.MobilePhone;
        cntDto.email = cnt.Email;
        return cntDto;
    }
}

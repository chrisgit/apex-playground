public class ContactService {
    public static void createContact(AccountRestDto dto, Account acc) {
        if (dto.contacts == null || dto.contacts.isEmpty()) {
            return;
        }

        List<Contact> contacts = new List<Contact>();
        for (ContactRestDto cntDto : dto.contacts) {
            contacts.add(new Contact(AccountId = acc.Id,
                FirstName = cntDto.forename, LastName = cntDto.surname,
                HomePhone = cntDto.homeNumber, MobilePhone = cntDto.mobileNumber,
                Email = cntDto.email));
        }

        insert contacts;

        dto.contacts = new List<ContactRestDto>();
        for (Contact cnt : contacts) {
            ContactRestDto cntDto = new ContactRestDto();
            cntDto.id = cnt.Id;
            cntDto.forename = cnt.FirstName;
            cntDto.surname = cnt.LastName;
            cntDto.homeNumber = cnt.HomePhone;
            cntDto.mobileNumber = cnt.MobilePhone;
            cntDto.email = cnt.Email;
            dto.contacts.add(cntDto);
        }
    }        
}

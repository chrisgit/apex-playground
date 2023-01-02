public class ContactService {
    public static void createContact(AccountRestDto dto, Account acc) {
        if (dto.contacts == null || dto.contacts.isEmpty()) {
            return;
        }

        List<Contact> contacts = new List<Contact>();
        for (ContactRestDto cntDto : dto.contacts) {
            Contact cnt = ContactRestDto.toSObject(cntDto);
            cnt.AccountId = acc.Id;
            contacts.add(cnt);
        }

        insert contacts;

        dto.contacts = new List<ContactRestDto>();
        for (Contact cnt : contacts) {
            dto.contacts.add(ContactRestDto.toDto(cnt));
        }
    }        
}

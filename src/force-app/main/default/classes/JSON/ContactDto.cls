public with sharing class ContactDto extends AbstractDto {
    public String firstname { get; set; }
    public String lastname { get; set; }
    public String email { get; set; }
    public AccountDto account { get; set; }
}

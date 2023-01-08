// Controller for /accounts endpount
public with sharing class AccountsRestController extends BaseController {
    public AccountsRestController(string uri) {
        super(uri);
    }

    protected override RestResponseWrapper handleGet() {
        // Ordinarily you would ask for a page of data ...
        List<Account> allAccounts = AccountAndContactQueries.getAllAccountsWithContacts();

        return Response.Ok(AccountRestDtoMapper.toDto(allAccounts));
    }

    protected override RestResponseWrapper handlePost() {
        string requestBody = Request.requestBody.toString();
        if (string.isBlank(requestBody)) {
            return Response.BadRequest();
        }
        AccountRestDto dto = (AccountRestDto)JSON.deserialize(requestBody, AccountRestDto.class);

        Id accountId = AccountContactService.createAccountAndContacts(dto);
        List<Account> accounts = AccountAndContactQueries.getAccountByIdWithContacts(accountId);

        return Response.Ok(AccountRestDtoMapper.toDto(accounts));
    }
}

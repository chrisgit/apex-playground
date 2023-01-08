// Controller for /account/{id} endpoint
public with sharing class AccountIdRestController extends BaseController {
    public AccountIdRestController(string uri) {
        super(uri);
    }

    protected override RestResponseWrapper handleGet() {
        string accountId = Request.pathParameters.get('id');
        List<Account> accounts = AccountAndContactQueries.getAccountByIdWithContacts(accountId);

        return Response.Ok(AccountRestDtoMapper.toDto(accounts));
    }

    protected override RestResponseWrapper handlePut() {
        string requestBody = Request.requestBody.toString();
        if (string.isBlank(requestBody)) {
            return Response.BadRequest();
        }
        AccountRestDto dto = (AccountRestDto)JSON.deserialize(requestBody, AccountRestDto.class);
        AccountContactService.updateAccount(dto, Request.pathParameters.get('id'));

        // Re-read updated data and respond
        return handleGet();
    }

    protected override RestResponseWrapper handleDelete() {
        string accountId = Request.pathParameters.get('id');
        AccountContactService.deleteAccountAndContacts(accountId);

        return Response.Ok();
    }
}

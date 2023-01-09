// Controller for /account/{id} endpoint
public with sharing class AccountIdContactRestController extends BaseController {
    public AccountIdContactRestController(string uri) {
        super(uri);
    }

    protected override RestResponseWrapper handleGet() {
        string accountId = Request.pathParameters.get('id');

        try {
            return Response.Ok(AccountRestDtoMapper.toDto(AccountContactQueries.getAccountByIdWithContacts(accountId)));
        } Catch (AccountNotFoundException exc) {
            return Response.NotFound();
        }
    }

    protected override RestResponseWrapper handlePut() {
        if (Request.hasBody() == false) {
            return Response.BadRequest();
        }
        string accountId = Request.pathParameters.get('id');
        AccountRestDto dto = (AccountRestDto)Request.deserialiseBody(AccountRestDto.class);
        AccountContactService.updateAccount(dto, accountId);

        // Re-read updated data and respond
        return Response.Ok(AccountRestDtoMapper.toDto(AccountContactQueries.getAccountByIdWithContacts(accountId)));
    }

    protected override RestResponseWrapper handleDelete() {
        string accountId = Request.pathParameters.get('id');
        AccountContactService.deleteAccountAndContacts(accountId);

        return Response.NoContent();
    }
}

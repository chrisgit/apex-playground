// Controller for /accounts endpount
public with sharing class AccountContactRestController extends BaseController {
    public AccountContactRestController(string uri) {
        super(uri);
    }

    protected override RestResponseWrapper handleGet() {
        return Response.Ok(AccountRestDtoMapper.toDto(AccountContactQueries.getAllAccountsWithContacts()));
    }

    protected override RestResponseWrapper handlePost() {
        if (Request.hasBody() == false) {
            return Response.BadRequest();
        }
        AccountRestDto dto = (AccountRestDto)Request.deserialiseBody(AccountRestDto.class);
        Id accountId = AccountContactService.createAccountAndContacts(dto);

        return Response.Ok(AccountRestDtoMapper.toDto(AccountContactQueries.getAccountByIdWithContacts(accountId)));
    }
}

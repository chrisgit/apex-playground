// Controller for /accounts endpount
public with sharing class AccountsRestController extends BaseController {
    public AccountsRestController(string uri) {
        super(uri);
    }

    protected override RestResponseWrapper handlePost() {
        string requestBody = Request.requestBody.toString();
        if (string.isBlank(requestBody)) {
            return Response.BadRequest();
        }
        AccountRestDto dto = (AccountRestDto)JSON.deserialize(requestBody, AccountRestDto.class);

        Savepoint sp = Database.setSavepoint();
        try {
            Account acc = AccountService.createAccount(dto);
            ContactService.createContact(dto, acc);
        } catch (Exception exc) {
            Database.rollback(sp);
            throw exc;
        }
        return Response.Ok(dto);
    }
}

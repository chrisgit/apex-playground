// Controller for /account/{id} endpoint
public with sharing class AccountIdRestController extends BaseController {
    public AccountIdRestController(string uri) {
        super(uri);
    }

    protected override RestResponseWrapper handlePut() {
        string requestBody = Request.requestBody.toString();
        if (string.isBlank(requestBody)) {
            return Response.BadRequest();
        }
        AccountRestDto dto = (AccountRestDto)JSON.deserialize(requestBody, AccountRestDto.class);
        AccountService.updateAccount(dto, Request.pathParameters.get('id'));
        return Response.Ok(dto);
    }
}

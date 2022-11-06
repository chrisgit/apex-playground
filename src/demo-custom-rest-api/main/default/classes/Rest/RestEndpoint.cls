@RestResource(UrlMapping = '/*')
global inherited sharing class RestEndpoint {
    private static RestDispatcher dispatcher = new RestDispatcher();

    static
    {
        dispatcher.register(new AccountsRestController('/accounts'));
        dispatcher.register(new AccountIdRestController('/accounts/{id}'));
    }

    @HttpGet
    global static void doGET() {
        execute(RequestType.HTTPGET);
    }

    @HttpPost
    global static void doPOST() {
        execute(RequestType.HTTPPOST);
    }

    @HttpPut
    global static void doPUT() {
        execute(RequestType.HTTPPUT);
    }

    @HttpPatch
    global static void doPATCH() {
        execute(RequestType.HTTPPATCH);
    }

    @HttpDELETE
    global static void doDELETE() {
        execute(RequestType.HTTPDELETE);
    }

    private static void execute(RequestType requestType) {
        dispatcher.execute(new RestRequestWrapper().setRequestType(requestType), new RestResponseWrapper());
    }
}

//Could not get automatic binding from the Request Body to Post method without specifying the top level parameter name
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_rest_methods.htm#ApexRESTUserDefinedTypes
// Code below works
/*
    @HttpPost
    global static void doPOST(AppDto app) {
        execute(RequestType.HTTPPOST);        
    }
    
    // Global DTO
    global class AppDto {
		public Integer ApplicantId;
        public string Forename;
        public string Surname;
        public string MobileNumber;
        public string HomeNumber;
        public string Email;
        public string PersonalId;
        public string PersonalIdentifierType;
        public Decimal LoanAmount;
		public List<AppDocDto> SupportingDocuments;
    }
    
	public with sharing class AppDocDto {
    	public string DocumentType;
    	public string DocumentUrl;
	}
*/
// With the following payload
/*
{
    "app": {
        "ApplicantId": 8899,
        "Forename": "Jay",
        "Surname": "Man",
        "MobileNumber":"+44 7722 123456",
        "HomeNumber":"+44 118 123456",
        "Email":"jay.man@test.com",
        "PersonalId":"K2882932288",
        "PersonalIdentifierType":"BRTPASS",
        "LoanAmount":100000.00,
        "SupportingDocuments":[
            {"DocumentType":"PD","DocumentUrl":"https://hoolaverse.blob.core.windows.net/Applicant/8899/Property_Deed.docx"},
            {"DocumentType":"PAYSL","DocumentUrl":"https://hoolaverse.blob.core.windows.net/Applicant/8899/Payslips.docx"}
        ]
    }
}
*/
// Hence now building a basic dispatcher and will de-serialise manually

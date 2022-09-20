@IsTest
public class AddressChangeEventTriggerHandlerTest {

    @IsTest 
    public static void Given_AddressEventRaised_When_TriggerIsHandled_Then_NewAddressIsPublishedToRestService() {
        Address_Change_Event__e evt = createAddressChangedPlatformEvent();
        AddressDto dto = new AddressDto(evt);
        String endpoint = String.format('callout:{0}/{1}', new String[] { AddressChangeEventTriggerHandler.NAMED_CREDENTIAL, evt.ObjectId__c });
        
    	HttpRequest expectedRequest = new HttpRequest();
        expectedRequest.setMethod('POST');
		expectedRequest.setHeader('Content-Type', 'text/plain');
        expectedRequest.setEndpoint(endpoint);
        expectedRequest.setBody(JSON.serialize(dto));
        MockHttpCalloutQueue mockCallout = new MockHttpCalloutQueue().expect(expectedRequest, httpResponseCreated());
        Test.setMock(HttpCalloutMock.class, mockCallout);
        
        Test.startTest();
        EventBus.publish(evt);
        Test.getEventBus().deliver();
        Test.stopTest();
        
        System.assertEquals(true, mockCallout.verifyExpectations(), 'Mock callout cannot verify the correct calls were made');
    }

    @IsTest
    public static void Given_AddressChangePlatformEvent_When_Configured_Then_Subscribed() {
        List<EventBusSubscriber> subscriber = [SELECT Name, Position, Retries, LastError FROM EventBusSubscriber WHERE Topic='Address_Change_Event__e' AND Name = 'AddressChangeEventTrigger' LIMIT 1];
        System.assertEquals(1, subscriber.size(), 'AddressChangeEventTrigger is not subscribed to the Address_Change_Event__e Platform event');
    }

    private static Address_Change_Event__e createAddressChangedPlatformEvent() {
        return new Address_Change_Event__e(
            ObjectId__c = '123456789',
            HouseNumberOrName__c = '22',
            AddressLine1__c = 'Acacia Avenue',
            TownOrCity__c = 'Littlehampton',
            PostCode__c = 'BAN ANA'
        );
    }

    private static HttpResponse httpResponseCreated() {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(201);
        return response;
    }
}

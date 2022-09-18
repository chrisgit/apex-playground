public class AddressChangeEventTriggerHandler {
    public static final string NAMED_CREDENTIAL = 'AddressRestService';
    
    public static void afterInsert(List<Address_Change_Event__e> allEvents) {
        if(allEvents.isEmpty()) {
            return;
        }
        
        for (Address_Change_Event__e evt : allEvents) {
            //string namedCredential = 'AddressRestService';
            string namedCredential = NAMED_CREDENTIAL;
            string endpoint = String.format('callout:{0}/{1}', new String[] { namedCredential, evt.ObjectId__c });
            AddressDto dto = new AddressDto(evt);
            
            System.debug(LOGGINGLEVEL.DEBUG, string.format('Publishing event for [{0}] to [{1}]', new String[] { evt.ObjectId__c, endpoint }));
            
            new HttpFutureCallout()
		        .setMethod('POST')
                .setEndpoint(endpoint)
        		.setHeader('Content-Type', 'text/plain')
        		.setBody(JSON.serialize(dto))
                .send();

            EventBus.TriggerContext.currentContext().setResumeCheckpoint(evt.ReplayId);
            if (Limits.getFutureCalls() >= Limits.getLimitFutureCalls()) {
                break;
            }            
        }
    }
}
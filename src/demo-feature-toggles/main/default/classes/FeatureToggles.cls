public class FeatureToggles {
    public static final String SEND_EMAIL_ON_CONTACT_NUMBER_CHANGE = 'SendEmailOnContactNumberChange';
    public static final String SEND_EMAIL_ON_CONTACT_ADDRESS_CHANGE = 'SendEmailOnContactAddressChange';
    public static final String SEND_ASB_MESSAGE_ON_CONTACT_CHANGE = 'SendAsbMessageOnContactChange';
    public static final String SEND_ASB_MESSAGE_TO_FIL_STAGE_CHANGED_TO_AWAITING_FUNDING = 'SendFilNotificationAwaitingFunding';
    
    @TestVisible
    private static FeatureToggleProvider provider = new FeatureToggleProvider(); 
        
    public static Boolean sendEmailOnContactNumberChange {
        get {
            return provider.getValueOrDefaultToFalse(SEND_EMAIL_ON_CONTACT_NUMBER_CHANGE);
        }
    }
    
    public static Boolean sendEmailOnContactAddressChange {
        get {
            return provider.getValueOrDefaultToFalse(SEND_EMAIL_ON_CONTACT_ADDRESS_CHANGE);
        }
    }
    
    public static Boolean sendAsbNotificationOnContactChange {
        get {
            return provider.getValueOrDefaultToFalse(SEND_ASB_MESSAGE_ON_CONTACT_CHANGE);
        }
    }

    public static Boolean notifyWhenStageChangedToAwaitingFunding {
        get {
            return provider.getValueOrDefaultToFalse(SEND_ASB_MESSAGE_TO_FIL_STAGE_CHANGED_TO_AWAITING_FUNDING);
        }
    }
}
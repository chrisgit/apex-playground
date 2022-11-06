public virtual class FeatureToggleProvider {
    public virtual Boolean getValueOrDefaultToFalse(String featureName) {
        Feature_Toggle__mdt setting = Feature_Toggle__mdt.getInstance(featureName);
        return setting == null ? false : setting.Enabled__c; 
    }
}
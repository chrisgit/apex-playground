@IsTest
public class MockFeatureToggleProvider extends FeatureToggleProvider {
        private Boolean defaultAllFeatures = null;
        private Map<String, Boolean> specificFeature = new Map<String, Boolean>();

        public override Boolean getValueOrDefaultToFalse(String key) {
            if (specificFeature.containsKey(key)) {
                return specificFeature.get(key);
            }

            if (defaultAllFeatures != null) {
                return defaultAllFeatures;
            }
            return false;
        }

        public MockFeatureToggleProvider defaultAllFeaturesTo(Boolean defaultValue) {
            defaultAllFeatures = defaultValue;
            return this;
        }

        public MockFeatureToggleProvider setToggleFor(String name, Boolean defaultValue) {
            specificFeature.put(name, defaultValue);
            return this;
        }
    }
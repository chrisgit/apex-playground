public with sharing class VirtualField extends VirtualBase {
    public override String showClass() {
        return 'VirtualField';
    }

    public override String accept(OopClassExamples example) {
        return example.evaluate(this);
    }
}

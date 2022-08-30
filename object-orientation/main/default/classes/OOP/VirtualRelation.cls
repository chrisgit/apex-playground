public with sharing class VirtualRelation extends VirtualBase {
    public override String showClass() {
        return 'VirtualRelation';
    }

    public override String accept(OopClassExamples example) {
        return example.evaluate(this);
    }
}
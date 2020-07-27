public with sharing class OopRelation extends OopAbstractBase implements IOopBase {
    public override String showClass() { 
        return 'OopRelation';
    }

    public String showUnderlyingClass() {
        return 'Interface - OopRelation';
    }

    public override String accept(OopClassExamples examples)
    {
        return examples.evaluate(this);
    }    
}

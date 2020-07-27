public with sharing class OopField extends OopAbstractBase implements IOopBase {
    public override String showClass() { 
        return 'OopField';
    }

    public String showUnderlyingClass() {
        return 'Interface - OopField';
    }

    public override String accept(OopClassExamples examples)
    {
        return examples.evaluate(this);
    }    
}

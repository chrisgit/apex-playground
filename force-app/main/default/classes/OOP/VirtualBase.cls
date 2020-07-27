public with sharing virtual class VirtualBase {
    public virtual String showClass() {
        return 'VirtualBase';
    }

    // Using the Visitor pattern
    public virtual String accept(OopClassExamples example) {
        return example.evaluate(this);
    }
}

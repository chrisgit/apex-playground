public inherited sharing class Token {
    public final Integer startPosition;
    public LexerTag tag;
    public Object tokenValue;

    public Token(Integer startPosition) {
        this.tag = LexerTag.UNKNOWN;
        this.startPosition = startPosition;
    }

    // Keep this for backward compatibility ... 
    public Token(LexerTag tag, Integer startPosition, Object value) {
        this.tag = tag;
        this.startPosition = startPosition;
        this.tokenValue = value;
    }

    public Token setTag(LexerTag tag) {
        this.tag = tag;
        return this;
    }

    public Token setTokenValue(Object tokenValue) {
        this.tokenValue = tokenValue;
        return this;
    }

	public override String toString() {
        return tokenValue.toString();
    }
}

@IsTest
public with sharing class LexerMock implements ILexer {
    protected List<Token> tokens = new List<Token>();
    protected Integer tokenPointer = 0;

    public void addToken(Token lexerToken) {
        tokens.add(lexerToken);
    }

    public void addTokens(List<Token> lexerTokens) {
        tokens.addAll(lexerTokens);
    }

    public Token nextToken() {
        if (tokenPointer >= tokens.size()) {
            return new Token(LexerTag.EOF, 0, '');
        }
        Token currentToken = tokens.get(tokenPointer);
        tokenPointer++;
        return currentToken;
    }
}

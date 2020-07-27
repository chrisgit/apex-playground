public inherited sharing class ExpressionParser {
    public static final String CREATING_PREDICATE_MESSAGE = 'Parser: Creating expression predicate [{0}] [{1}] [{2}]';
    public static final String CREATING_RANGE_PREDICATE_MESSAGE = 'Parser: Creating range on [{0}] from [{1}] to [{2}]';
    public static final String CREATING_PREDICATE_JOIN_MESSAGE = 'Parser: Creating join expression predicate';

    private Integer maximumRecursionDepth = 30;
    private Integer recursionDepth = 0;
    public List<Token> acceptedTokens = new List<Token>();

    protected ILexer lexer;

    private static final List<LexerTag> LOGICAL_OPERATORS = new List<LexerTag> {
        LexerTag.LOGICAL_OPERATOR_AND, LexerTag.LOGICAL_OPERATOR_OR
    };

    private static final List<LexerTag> BINARY_OPERATORS = new List<LexerTag> {
        LexerTag.OPERATOR_EQUALS, LexerTag.OPERATOR_GREATERTHAN,
        LexerTag.OPERATOR_GREATERTHANEQUAL, LexerTag.OPERATOR_LESSTHAN,
        LexerTag.OPERATOR_LESSTHANEQUAL, LexerTag.OPERATOR_NOTEQUAL
    };

    private static final List<LexerTag> LITERALS = new List<LexerTag> {
        LexerTag.DATE_LITERAL,
        LexerTag.DECIMAL_LITERAL,
        LexerTag.STRING_LITERAL,
        LexerTag.NULL_LITERAL
    };

    protected Integer lookAheadCount = 5;
    protected Token[] lookAheadBuffer;
    protected Integer lookAheadPointer = 0;
    
    // We don't actually need lookahead but can be obatained using the lookAheadTokens array
    // if (this.lookAheadTokens(1).Tag == LexerTag.IDENTIFIER ...
    private Token lookAheadTokens(Integer lookAheadPosition) {
        Integer actualTokenPosition = math.mod(this.lookAheadPointer + lookAheadPosition - 1,  this.lookAheadCount);
        return lookAheadBuffer[actualTokenPosition];
    }

    protected Token currentToken {
        get {
            return lookAheadTokens(1);
        }
    }

    public ExpressionParser(String expression) {
        this((ILexer) new Lexer(expression));
    }

    public ExpressionParser(ILexer lexer) {
        this.lexer = lexer;
        this.lookAheadBuffer = new Token[this.lookAheadCount];
        for (Integer bufferPosition = 0; bufferPosition <= this.lookAheadCount - 1; bufferPosition++) {
            consume();
        }
    }

    public BasePredicate parse() {
        BasePredicate expression = this.filter();
        expect(LexerTag.EOF);
        return expression;
    }

    private BasePredicate filter() {
        BasePredicate leftCondition = statement();

        while (acceptable(LOGICAL_OPERATORS)) {
            Token operatorToken = expect(LOGICAL_OPERATORS);
            BasePredicate rightCondition = statement();
            leftCondition = createExpressionJoin(leftCondition, rightCondition, operatorToken);
        }
// expect(EOF) ...
        return leftCondition;
    }

    private BasePredicate statement() {
        if (acceptable(LexerTag.FUNCTION_RANGE)) {
            return range();
        } else {
            return filterExpression();
        }
    }

    private BasePredicate filterExpression() {
        Token identifier = expect(LexerTag.IDENTIFIER);
        Token operator = expect(BINARY_OPERATORS);
        Token literal = expect(LITERALS);

        return createExpressionPredicate(identifier, operator, literal);
    }

    private BasePredicate range() {
        expect(LexerTag.FUNCTION_RANGE);
        expect(LexerTag.LBRACK);
        Token identifier = expect(LexerTag.IDENTIFIER);
        expect(LexerTag.COMMA);
        Token startRange = expect(LITERALS);
        expect(LexerTag.COMMA);
        Token endRange = expect(LITERALS);
        expect(LexerTag.RBRACK);

        return createRangePredicate(identifier, startRange, endRange);
    }

    private void consume() {
        this.lookAheadBuffer[this.lookAheadPointer] = this.lexer.nextToken();
        this.lookAheadPointer = math.mod(this.lookAheadPointer + 1, this.lookAheadCount);
    }

    private Boolean acceptable(LexerTag acceptToken) {
        if (acceptToken == this.currentToken.tag) {
            return true;
        }
        return false;
    }

    private Boolean acceptable(List<LexerTag> acceptableTokens) {
        if (acceptableTokens.contains(this.currentToken.tag)) {
            return true;
        }
        return false;
    }

    private Token expect(LexerTag expectedToken) {
        if (this.acceptable(expectedToken)) {
            Token acceptedToken = this.currentToken;
            consume();
            return acceptedToken;
        }
        throw new SyntaxErrorException('Expected ' + expectedToken + ' got ' + this.currentToken.tokenValue);        
    }

    private Token expect(List<LexerTag> expectedTokens) {
        if (acceptable(expectedTokens)) {
            Token acceptedToken = this.currentToken;
            consume();
            return acceptedToken;
        }
        throw new SyntaxErrorException('Expected one of the following ' + tokenTagsToString(expectedTokens) + ', got ' + this.currentToken.tokenValue);
    }

    private String tokenTagsToString(List<LexerTag> tags) {
        List<String> tagNames = new List<String>();
        for (LexerTag tag : tags) {
            tagNames.add(tag.name());
        }
        return String.join(tagNames, ', ');
    }

    private BasePredicate createExpressionPredicate(Token identifier, Token operator, Token literal) {
        StaticLogger.debug(CREATING_PREDICATE_MESSAGE, identifier.tokenValue, operator.tokenValue, literal.tokenValue);
        SObjectField field = stringIdentifierToObjectReference(identifier.tokenValue);
        BasePredicate filterCondition = null;
        switch on operator.tag {
            when OPERATOR_EQUALS {
                filterCondition = new BasicPredicateFilterEqual(field, literal.tokenValue);
            }
            when OPERATOR_GREATERTHAN {
                filterCondition = new BasicPredicateFilterGreaterThan(field, literal.tokenValue);
            }
            when OPERATOR_LESSTHAN {
                filterCondition = new BasicPredicateFilterLessThan(field, literal.tokenValue);
            }
        }
        
        return filterCondition;
    }

    private BasePredicate createExpressionJoin(BasePredicate left, BasePredicate right, Token joinType) {
        StaticLogger.debug(CREATING_PREDICATE_JOIN_MESSAGE);
        BasePredicate filterCondition = null;
        switch on joinType.tag {
            when LOGICAL_OPERATOR_AND {
                filterCondition = new BasicPredicateFilterAnd(left, right);
            }
            when LOGICAL_OPERATOR_OR {
                filterCondition = new BasicPredicateFilterOr(left, right);
            }
        }
        return filterCondition;
    }

    private BasePredicate createRangePredicate(Token identifier, Token startRange, Token endRange) {
        StaticLogger.debug(CREATING_RANGE_PREDICATE_MESSAGE, identifier.tokenValue, startRange.tokenValue, endRange.tokenValue);
        SObjectField field = stringIdentifierToObjectReference(identifier.tokenValue);
        BasePredicate filterCondition = new BasicPredicateFilterRange(field, startRange.tokenValue, endRange.tokenValue);
        return filterCondition;
    }

    private SObjectField stringIdentifierToObjectReference(Object identifier) {
        List<String> identifierElements = String.valueOf(identifier).split('\\.');
        String objectName = identifierElements[0];
        String fieldName = identifierElements[1];
        ObjectSchema schema = ObjectFactory.getSchemaForSObject(objectName);
        return schema.getField(fieldName);
    }
}

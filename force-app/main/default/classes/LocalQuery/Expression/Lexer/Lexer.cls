@SuppressWarnings('PMD.CyclomaticComplexity')
public inherited sharing class Lexer implements ILexer {
    public static final String SEARCH_TOKEN_MESSAGE = 'Lexer: Attempting to match token against [{0}]';
    public static final String TOKEN_CONVERSION_MESSAGE = 'Lexer: Attempted to convert [{0}] to [{1}]';
    public static final String TOKEN_MATCH_MESSAGE = 'Lexer: Matched token [{0}] as [{1}]';
    public static final String END_OF_TOKENS_MESSAGE = 'Lexer: Token Stream EOF';

    public static final String SINGLE_QUOTE_CHARACTER = '\'';
    public static final String DOUBLE_QUOTE_CHARACTER = '"';

    public static final Map<String, LexerTag> RESERVEDWORDS = new Map<String, LexerTag> {
        'and' => LexerTag.LOGICAL_OPERATOR_AND,
        'or' => LexerTag.LOGICAL_OPERATOR_OR,
        'not' => LexerTag.LOGICAL_OPERATOR_NOT,
        'range' => LexerTag.FUNCTION_RANGE
    };

    public static final List<String> WHITESPACE_CHARACTERS = new List<String> { ' ', '\t', '\n', '\r', '' };
    public static final String SEPARATOR_CHARACTERS = ',) ';

    protected String input;
    protected Integer inputLength;

    public Integer currentCharacterPosition = 0;
    public String currentCharacter;

    public Lexer(String input) {
        this.input = input;
        this.inputLength = input.length();
        setCurrentCharacter(currentCharacterPosition);
    }

    public Token nextToken() {

        advanceToNextCharacterIgnoringWhiteSpace();
        Token tok = new Token(this.currentCharacterPosition);

        if (hasValue(this.currentCharacter) == false) {
            StaticLogger.debug(END_OF_TOKENS_MESSAGE);
            return tok.setTag(LexerTag.EOF);
        }

        Integer tokenStartPosition = this.currentCharacterPosition;
        if (tokeniseSingleLetters(tok)) {
            return tok;
        }
        if (tokeniseComparisonOperators(tok)) {
            return tok;
        }
        if (tokeniseStringLiterals(tok)) {
            return tok;
        }
        if (tokeniseNumbers(tok)) {
            return tok;
        }
        if (tokeniseIdentifiers(tok)) {
            return tok;
        }

        StaticLogger.debug(TOKEN_MATCH_MESSAGE, this.currentCharacter, 'Unknown');
        return new Token(LexerTag.UNKNOWN, this.currentCharacterPosition, this.currentCharacter);
    }

    private Boolean tokeniseSingleLetters(Token tok) {
        switch on this.currentCharacter {
            // Make these constants?
            when '(' {
                tok.setTag(LexerTag.LBRACK).setTokenValue('(');
            }
            when ')' {
                tok.setTag(LexerTag.RBRACK).setTokenValue(')');
            }
            when ',' {
                tok.setTag(LexerTag.COMMA).setTokenValue(',');
            }
            when '/' {
                tok.setTag(LexerTag.FORWARD_SLASH).setTokenValue('/');
            }
            when '?' {
                tok.setTag(LexerTag.QUESTION_MARK).setTokenValue('?');                
            }
            when '.' {
                tok.setTag(LexerTag.DOT).setTokenValue('.');                
            }
            when '*' {
                tok.setTag(LexerTag.ASTERISK).setTokenValue('.');                
            }
            when ':' {
                tok.setTag(LexerTag.COLON).setTokenValue(':');                
            }
            when ';' {
                tok.setTag(LexerTag.SEMI_COLON).setTokenValue(';');                
            }
            when else {
                return false;
            }
        }

        StaticLogger.debug(TOKEN_MATCH_MESSAGE, tok.tokenValue, 'Single Character');
        advanceToNextCharacter();
        return true;
    }

    private Boolean tokeniseComparisonOperators(Token tok) {
        if ('=!<>'.contains(this.currentCharacter) == false) {
            return false;
        }

        String operator = this.currentCharacter;
        advanceToNextCharacter();
        if (hasValue(this.currentCharacter) && this.currentCharacter == '=') {
            operator = operator + '=';
            advanceToNextCharacter();
        }

        return resolveComparisonOperator(tok, operator);
    }

    private Boolean tokeniseStringLiterals(Token tok) {
        if (this.currentCharacter != '"') {
            return false;
        }

        StaticLogger.Debug(SEARCH_TOKEN_MESSAGE, 'String Literal');
        Integer tokenStartPosition = this.currentCharacterPosition;
        advanceToNextOccurenceOf(DOUBLE_QUOTE_CHARACTER);
        if (!hasValue(this.currentCharacter))
        {
            throw new UnterminatedLiteralException(); // Unterminated String
        }
        String literalValue = input.substring(tokenStartPosition + 1, this.currentCharacterPosition);
        StaticLogger.Debug(TOKEN_MATCH_MESSAGE, literalValue, 'String Literal');
        tok.setTag(LexerTag.STRING_LITERAL).setTokenValue(literalValue);
        advanceToNextCharacter();

        return true;
    }

    private Boolean tokeniseNumbers(Token tok) {
        if (this.currentCharacter.isNumeric() || this.currentCharacter == '-') {    
            StaticLogger.debug(SEARCH_TOKEN_MESSAGE, 'Number');            
            if (tokeniseMinus(tok)) {
                return true;
            }
            if (parseNumber(tok)) {
                return true;
            }
        }
        return false;
    }

    // Can return Account.Name as three tokens Account (Identifier) . (Dot) Name (Identifier) but simpler to treat as a single identifier
    private Boolean tokeniseIdentifiers(Token tok) {
        if (this.currentCharacter.isAlpha() == false) {
            return false;
        }
        StaticLogger.debug(SEARCH_TOKEN_MESSAGE, 'Identifier');

        Integer tokenStartPosition = this.currentCharacterPosition;

        do {
            advanceToNextCharacter();
        } while (validIdentifierCharacter(this.currentCharacter));

        String identifierName = input.substring(tokenStartPosition, this.currentCharacterPosition);
        String reservedWordKey = identifierName.toLowerCase();
        if (reservedWords.containsKey(reservedWordKey)) {
            tok.setTag(reservedWords.get(reservedWordKey)).setTokenValue(reservedWordKey);
        } else { 
            tok.setTag(LexerTag.IDENTIFIER).setTokenValue(identifierName);
        }

        StaticLogger.Debug(TOKEN_MATCH_MESSAGE, identifierName, 'Identifier');
        
        return true;
    }

    private Boolean tokeniseMinus(Token tok) {
        if (this.currentCharacter == '-') {
            // Could be a minus or a negative number
            String peekCharacter = peekNext();
            if (hasValue(peekCharacter) == false || peekCharacter.isNumeric() == false)
            {
                tok.setTag(LexerTag.MINUS).setTokenValue('-');
                advanceToNextCharacter();
                return true;
            }
        }
        return false;
    }

    private Boolean resolveComparisonOperator(Token tok, String operator) {

        switch on operator {
            when '=' {
                tok.setTag(LexerTag.UNKNOWN).setTokenValue('=');
            }
            when '!' {
                tok.setTag(LexerTag.UNKNOWN).setTokenValue('!');
            }
            when '==' {
                tok.setTag(LexerTag.OPERATOR_EQUALS).setTokenValue('==');
            }
            when '!=' {
                // Should this be Token NOT and Token Equals
                tok.setTag(LexerTag.OPERATOR_NOTEQUAL).setTokenValue('!=');
            }            
            when '<' {
                tok.setTag(LexerTag.OPERATOR_LESSTHAN).setTokenValue('<');
            }
            when '<=' {
                tok.setTag(LexerTag.OPERATOR_LESSTHANEQUAL).setTokenValue('<=');
            }
            when '>' {
                tok.setTag(LexerTag.OPERATOR_GREATERTHAN).setTokenValue('>');
            }
            when '>=' {
                tok.setTag(LexerTag.OPERATOR_GREATERTHANEQUAL).setTokenValue('>=');
            }
            when else {
                return false;
            }
        }

        StaticLogger.debug(TOKEN_MATCH_MESSAGE, tok.tokenValue, 'Comparitor');

        return true;        
    }

    private Boolean parseNumber(Token tok)
    {
        Integer startPosition = this.currentCharacterPosition;
        advanceToNextOccurenceOf(SEPARATOR_CHARACTERS);
        String identifier = input.substring(startPosition, this.currentCharacterPosition);
        try {
            Date numberIsDate = Date.valueOf(identifier);
            tok.setTag(LexerTag.DATE_LITERAL).setTokenValue(numberIsDate);
            StaticLogger.debug(TOKEN_MATCH_MESSAGE, identifier, 'Date');
            return true;
        } catch (TypeException e) {
            StaticLogger.debug(TOKEN_CONVERSION_MESSAGE, identifier, 'Date');
        }

        try {
            Decimal numberIsDecimal = Decimal.valueOf(identifier);
            tok.setTag(LexerTag.DECIMAL_LITERAL).setTokenValue(numberIsDecimal);
            StaticLogger.debug(TOKEN_MATCH_MESSAGE, identifier, 'Number/Decimal');
            return true;
        } catch(TypeException e) {
            StaticLogger.debug(TOKEN_CONVERSION_MESSAGE, identifier, 'Number/Decimal');
        }

        return false;
    }

    private Boolean parseNumberOld(Token tok)
    {
        Integer startPosition = this.currentCharacterPosition;
        do {
            this.advanceToNextCharacter();
        } while (hasValue(this.currentCharacter) && this.currentCharacter.isNumeric());

        // Suspect could be a date? Push characters back into the stream and separate method for parse date?
        if (hasValue(this.currentCharacter) && '-' == this.currentCharacter) {
            advanceToNextOccurenceOf(SEPARATOR_CHARACTERS);
            String dateIdentifier = input.substring(startPosition, this.currentCharacterPosition);
            try {
                Date numberIsDate = Date.valueOf(dateIdentifier);
                tok.setTag(LexerTag.DATE_LITERAL).setTokenValue(numberIsDate);
                StaticLogger.debug(TOKEN_MATCH_MESSAGE, dateIdentifier, 'Date');
                return true;
            } catch (TypeException e) {
                System.debug(LoggingLevel.DEBUG, 'Attempted to convert [' + dateIdentifier + '] to date');
            }
        }

        // Suspect decimal number
        if (hasValue(this.currentCharacter) && '.' == this.currentCharacter) {
            advanceToNextCharacter();
            while(hasValue(this.currentCharacter) && this.currentCharacter.isNumeric()) {
                advanceToNextCharacter();
            }
        }

        String numberIdentifier = input.substring(startPosition, this.currentCharacterPosition);
        try {
            Decimal numberIsDecimal = Decimal.valueOf(numberIdentifier);
            tok.setTag(LexerTag.DECIMAL_LITERAL).setTokenValue(numberIsDecimal);
            StaticLogger.debug(TOKEN_MATCH_MESSAGE, numberIdentifier, 'Number/Decimal');
            return true;
        } catch(TypeException e) {
            System.debug(LoggingLevel.DEBUG, 'Attempted to convert [' + numberIdentifier + '] to number');
        }

        tok.setTag(LexerTag.UNKNOWN).setTokenValue(numberIdentifier);
        return true;
    }

    public Boolean validIdentifierCharacter(String inputCharacter) {
        if (hasValue(inputCharacter) && (inputCharacter.isAlphanumeric() || inputCharacter == '.')) {
                return true;
            }
        return false;
    }

    // The built in isBlank/isEmpty allow null which is being used as a terminator in the lexer
    public Boolean isWhiteSpace(String inputCharacter) {
        if (WHITESPACE_CHARACTERS.contains(inputCharacter)) {
            return true;
        }
        return false;
    }

    public Boolean hasValue(String inputCharacter) {
        return null != inputCharacter;
    }

    public Boolean hasNext() {
        return this.currentCharacterPosition + 1 < this.inputLength;
    }

    public String peek(Integer relativePositionFromCurrent) {
        Integer absolutePosition = this.currentCharacterPosition + relativePositionFromCurrent;
        if (absolutePosition >= this.inputLength || absolutePosition < 0) {
            return null;
        } else {
            return this.input.mid(absolutePosition, 1);
        }
    }

    public String peekNext() {
        return peek(1);
    }

    public void advanceToNextOccurenceOf(String matchCharacters) {
        do {
            advanceToNextCharacter();
        } while (hasValue(this.currentCharacter) && (matchCharacters.contains(this.currentCharacter) == false));
    }

    // Actually these are private
    public void advanceToNextCharacterIgnoringWhiteSpace() {
        while(isWhiteSpace(this.currentCharacter)) {
            advanceToNextCharacter();
        }
    }

    public void advanceToNextCharacter()
    {
        setCurrentCharacter(++this.currentCharacterPosition);
    }

    // change to peek and return next character?
    public void setCurrentCharacter(Integer position) {
        this.currentCharacterPosition = position;
        if (this.currentCharacterPosition < 0 || this.currentCharacterPosition >= this.inputLength) {
            this.currentCharacter = null;
        } else {
            this.currentCharacter = this.input.mid(this.currentCharacterPosition, 1);
        }
    }
}

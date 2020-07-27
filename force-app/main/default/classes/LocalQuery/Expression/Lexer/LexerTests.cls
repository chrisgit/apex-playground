@IsTest
public class LexerTests {
    // ***************************
    // Empty streams
    // ***************************
    @IsTest
    public static void whenInputIsEmpty() {
        Lexer l = new Lexer('');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.EOF, t.tag, 'Lexer: No input returns EOF');
    }

    @IsTest
    public static void whenInputIsAllSpaces() {
        Lexer l = new Lexer('                                                      ');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.EOF, t.tag, 'Lexer: Input spaces return EOF');
    }

    // ***************************
    // Single characters and parenthesis
    // ***************************
    @IsTest
    public static void whenInputLeftRoundBracket() {
        Lexer l = new Lexer('(');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.LBRACK, t.tag, 'Lexer: Open round bracket, expect tag');
    }

    @IsTest
    public static void whenInputRightRoundBracket() {
        Lexer l = new Lexer(')');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.RBRACK, t.tag, 'Lexer: Close round bracket, expect tag');
    }

    // ***************************
    // String Literals
    // ***************************
    @IsTest
    public static void whenInputDoubleQuoteStringLiteral() {
        Lexer l = new Lexer('"Foo"');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.STRING_LITERAL, t.tag, 'Lexer: String literal expect tag');
        System.assertEquals('Foo', t.tokenValue, 'Lexer: String literal expect value');
    }

    @IsTest
    public static void whenInputDoubleQuoteLiteralWithEmbeddedSingleQuote() {
        Lexer l = new Lexer('"Brian O\'Conner"'); // Martin O'Neil

        Token t = l.nextToken();

        System.assertEquals(LexerTag.STRING_LITERAL, t.tag, 'Lexer: String literal expect tag');
        System.assertEquals('Brian O\'Conner', t.tokenValue, 'Lexer: String literal expect value');
    }

    @IsTest
    public static void whenUnterminatedDoubleQuoteStringLiteral() {
        Lexer l = new Lexer('"Foo');

        Boolean exceptionThrown = false;
        try {
            Token t = l.nextToken();
        } catch (UnterminatedLiteralException ex) {
            exceptionThrown = true;
        }

        System.assert(exceptionThrown, 'Lexer: did not throw for unterminated string literal');
    }

    // ***************************
    // Number Literals
    // ***************************
    @IsTest
    public static void whenMinusSymbol() {
        Lexer l = new Lexer('-');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.MINUS, t.tag, 'Lexer: Minus expect tag');
        System.assertEquals('-', t.tokenValue, 'Lexer: Minus expect value');
    }

    @IsTest
    public static void whenNegativeNumber() {
        Lexer l = new Lexer('-123456789.98');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.DECIMAL_LITERAL, t.tag, 'Lexer: Negative number expect tag');
        System.assertEquals(-123456789.98, t.tokenValue, 'Lexer: Negative number expect value');
    }

    @IsTest
    public static void whenPositiveNumber() {
        Lexer l = new Lexer('123456789.98');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.DECIMAL_LITERAL, t.tag, 'Lexer: Positive number expect tag');
        System.assertEquals(123456789.98, t.tokenValue, 'Lexer: Negative number expect value');
    }

    @IsTest
    public static void whenNumberNextToSeparator() {
        Lexer l = new Lexer('123456789.98)');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.DECIMAL_LITERAL, t.tag, 'Lexer: Number next to separator expect tag');
        System.assertEquals(123456789.98, t.tokenValue, 'Lexer: Number next to separator expect value');
    }

    // ***************************
    // Date Literals
    // ***************************
    @IsTest
    public static void whenDate() {
        Lexer l = new Lexer('2020-02-24');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.DATE_LITERAL, t.tag, 'Lexer: Date expect tag');
        System.assertEquals(Date.newInstance(2020, 02, 24), t.tokenValue, 'Lexer: Date expect value');
    }

    // ***************************
    // Comparison operators
    // ***************************
    @IsTest
    public static void whenEquals() {
        Lexer l = new Lexer('==');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.OPERATOR_EQUALS, t.tag, 'Lexer: Equals expect tag');
        System.assertEquals('==', t.tokenValue, 'Lexer: Equals expect value');
    }

    @IsTest
    public static void whenNotEqual() {
        Lexer l = new Lexer('!=');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.OPERATOR_NOTEQUAL, t.tag, 'Lexer: Not equals expect tag');
        System.assertEquals('!=', t.tokenValue, 'Lexer: Not equals expect value');
    }

    @IsTest
    public static void whenGreaterThan() {
        Lexer l = new Lexer('>');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.OPERATOR_GREATERTHAN, t.tag, 'Lexer: Greater than expect tag');
        System.assertEquals('>', t.tokenValue, 'Lexer: Greater than expect value');
    }

    @IsTest
    public static void whenGreaterThanEqualTo() {
        Lexer l = new Lexer('>=');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.OPERATOR_GREATERTHANEQUAL, t.tag, 'Lexer: Greater than equal expect tag');
        System.assertEquals('>=', t.tokenValue, 'Lexer: Greater than equal expect value');
    }

    @IsTest
    public static void whenLessThan() {
        Lexer l = new Lexer('<');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.OPERATOR_LESSTHAN, t.tag, 'Lexer: Less than expect tag');
        System.assertEquals('<', t.tokenValue, 'Lexer: Greater than expect value');
    }

    @IsTest
    public static void whenLessThanEqualTo() {
        Lexer l = new Lexer('<=');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.OPERATOR_LESSTHANEQUAL, t.tag, 'Lexer: Less than equal expect tag');
        System.assertEquals('<=', t.tokenValue, 'Lexer: Less than equal expect value');
    }

    // ***************************
    // Assignment
    // ***************************
    @IsTest
    public static void whenAssignment() {
        Lexer l = new Lexer('=');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.UNKNOWN, t.tag, 'Lexer: Assignment expect tag');
        System.assertEquals('=', t.tokenValue, 'Lexer: Assignment expect value');
    }

    // ***************************
    // Logical operators
    // ***************************
    @IsTest
    public static void whenAnd() {
        Lexer l = new Lexer('and');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.LOGICAL_OPERATOR_AND, t.tag, 'Lexer: AND expect tag');
        System.assertEquals('and', t.tokenValue, 'Lexer: AND expect value');
    }

    @IsTest
    public static void whenOr() {
        Lexer l = new Lexer('or');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.LOGICAL_OPERATOR_OR, t.tag, 'Lexer: OR expect tag');
        System.assertEquals('or', t.tokenValue, 'Lexer: AND expect value');
    }

    // ***************************
    // Identifiers
    // ***************************
    @IsTest
    public static void whenInputIdentifier() {
        Lexer l = new Lexer('Foo.Bar');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.IDENTIFIER, t.tag, 'Lexer: Identifier expect tag');
        System.assertEquals('Foo.Bar', t.tokenValue, 'Lexer: Identifier expect value');
    }

    // ***************************
    // Other Keywords
    // ***************************
    @IsTest
    public static void whenInputIsRange() {
        Lexer l = new Lexer('range');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.FUNCTION_RANGE, t.tag, 'Lexer: Keyword Range expect tag');
        System.assertEquals('range', t.tokenValue, 'Lexer: Keyword Range expect value');
    }

    // ***************************
    // Complete expression
    // ***************************
    @IsTest
    public static void whenInputIsExpression() {
        Lexer l = new Lexer('Foo == "Bar"');

        Token t = l.nextToken();
        System.assertEquals(LexerTag.IDENTIFIER, t.tag, 'Lexer: Expression Identifier tag');
        System.assertEquals('Foo', t.tokenValue, 'Lexer: Expression Identifier value');

        t = l.nextToken();
        System.assertEquals(LexerTag.OPERATOR_EQUALS, t.tag, 'Lexer: Expression operator tag');

        t = l.nextToken();
        System.assertEquals(LexerTag.STRING_LITERAL, t.tag, 'Lexer: Expression literal tag');
        System.assertEquals('Bar', t.tokenValue, 'Lexer: Expression literal value');
    }

    @IsTest
    public static void whenInputIsRangeFunction() {
        Lexer l = new Lexer('range(Foo.Bar,111,222)');

        Token t = l.nextToken();

        System.assertEquals(LexerTag.FUNCTION_RANGE, t.tag, 'Lexer: Range Function tag');
        System.assertEquals('range', t.tokenValue, 'Lexer: Range Function value');

        t = l.nextToken();
        System.assertEquals(LexerTag.LBRACK, t.tag, 'Lexer: Range Function open bracket');

        t = l.nextToken();
        System.assertEquals(LexerTag.IDENTIFIER, t.tag, 'Lexer: Range Function identifier tag');
        System.assertEquals('Foo.Bar', t.tokenValue, 'Lexer: Range Function identifier value');

        t = l.nextToken();
        System.assertEquals(LexerTag.COMMA, t.tag, 'Lexer: Range Function (first) comma');

        t = l.nextToken();
        System.assertEquals(LexerTag.DECIMAL_LITERAL, t.tag, 'Lexer: Range Function (first) literal tag');
        System.assertEquals(111, t.tokenValue, 'Lexer: Range Function (first) literal value');

        t = l.nextToken();
        System.assertEquals(LexerTag.COMMA, t.tag, 'Lexer: Range Function (second) comma');

        t = l.nextToken();
        System.assertEquals(LexerTag.DECIMAL_LITERAL, t.tag, 'Lexer: Range Function (second) literal tag');
        System.assertEquals(222, t.tokenValue, 'Lexer: Range Function (second) literal value');

        t = l.nextToken();
        System.assertEquals(LexerTag.RBRACK, t.tag, 'Lexer: Range Function close bracket');
    }
}

public with sharing class UnknownRestException extends CustomRestException {
    private static final Integer HTTP_STATUS_CODE = 500;

    public virtual override Integer getHttpStatusCode() {
        return HTTP_STATUS_CODE;
    }

    public virtual override ErrorCategory getErrorCategory() {
        return CustomRestException.ErrorCategory.UNKNOWN_ERROR;
    }

    public static UnknownRestException raise(Exception ex) {
        string message = string.format('{0}\n\n{1}', new string[] { ex.getMessage(), ex.getStackTraceString() });
        return (UnknownRestException)(new UnknownRestException(message));
    }
}

public with sharing abstract class CustomRestException extends Exception {
    private static final Integer DEFAULT_HTTP_STATUS_CODE = 500;
    private static final ErrorCategory DEFAULT_ERROR_CATEGORY = ErrorCategory.UNKNOWN_ERROR;

    public enum ErrorCategory {
        UNKNOWN_ERROR,
        REQUEST_ERROR,
        INTERNAL_API_ERROR
    }

    public virtual Integer getHttpStatusCode() {
        return DEFAULT_HTTP_STATUS_CODE;
    }
    
    public virtual ErrorCategory getErrorCategory() {
        return DEFAULT_ERROR_CATEGORY;
    }
}

public with sharing class InvalidRequestException Extends CustomRestException {
    private static final Integer HTTP_STATUS_CODE = 400;

    public virtual override Integer getHttpStatusCode() {
        return HTTP_STATUS_CODE;
    }

    public virtual override ErrorCategory getErrorCategory() {
        return CustomRestException.ErrorCategory.REQUEST_ERROR;
    }

    public static void raise(string message) {
        throw new InvalidRequestException(message);
    }
}


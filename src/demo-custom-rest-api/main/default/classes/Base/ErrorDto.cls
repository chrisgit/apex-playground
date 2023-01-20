public class ErrorDto {
    public CustomRestException.ErrorCategory errorCode;
    public string message;

    public ErrorDto(CustomRestException ex) {
        this.errorCode = ex.getErrorCategory();
        this.message = ex.getMessage();
    }
}

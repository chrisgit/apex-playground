public class ErrorResponseDto {
    public ErrorDto error;

    public ErrorResponseDto(CustomRestException ex) {
        this.error = new ErrorDto(ex);
    }
}

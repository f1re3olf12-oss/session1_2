class ApiResult<T> {}

class ApiSuccess<T> extends ApiResult<T> {
  T data;
  ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  String message;
  ApiFailure(this.message);
}

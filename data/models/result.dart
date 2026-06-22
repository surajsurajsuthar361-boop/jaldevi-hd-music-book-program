abstract class Result<T> {
  const Result();

  factory Result.initial() = Initial<T>;
  factory Result.loading() = Loading<T>;
  factory Result.success(T data) = Success<T>;
  factory Result.error(String message) = Error<T>;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    if (this is Initial<T>) {
      return initial();
    } else if (this is Loading<T>) {
      return loading();
    } else if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Error<T>) {
      return error((this as Error<T>).message);
    }
    throw Exception('Unhandled state: $this');
  }

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String message)? error,
    required R Function() orElse,
  }) {
    if (this is Initial<T> && initial != null) {
      return initial();
    } else if (this is Loading<T> && loading != null) {
      return loading();
    } else if (this is Success<T> && success != null) {
      return success((this as Success<T>).data);
    } else if (this is Error<T> && error != null) {
      return error((this as Error<T>).message);
    }
    return orElse();
  }
}

class Initial<T> extends Result<T> {
  const Initial();
}

class Loading<T> extends Result<T> {
  const Loading();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Error<T> extends Result<T> {
  const Error(this.message);
  final String message;
}

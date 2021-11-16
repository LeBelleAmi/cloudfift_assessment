//exception class
class FailureException {
  final String message;

  FailureException(this.message);

  @override
  String toString() => message;
}

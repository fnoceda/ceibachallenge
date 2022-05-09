class Failure {
  int code; //200, etc
  String message; //error or success message
  Failure({
    required this.code,
    required this.message,
  });
}

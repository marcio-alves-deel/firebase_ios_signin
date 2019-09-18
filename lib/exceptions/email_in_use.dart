class EmailInUseException implements Exception {
  String message;
  EmailInUseException(this.message);
}

class Failure {
  final String message;
  // Constructor constante para permitir subclases si queremos
  const Failure([this.message = 'An unexpected error occurred']);
}

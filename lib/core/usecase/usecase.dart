import 'package:blogapp/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

// Usamos Generics:
// Type: Lo que devuelve si tiene éxito (ej: User, String, List<Blog>)
// Params: Los parámetros que necesita para ejecutarse (ej: UserSignUpParams)
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

// Clase auxiliar para cuando un caso de uso no requiera parámetros
class NoParams {}

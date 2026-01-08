import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:blogapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  // Inyección de dependencias del DataSource
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  // Wrapper para manejar errores y no repetir try-catch
  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final userId = await fn();
      return right(userId); // fpdart: Success
    } on ServerException catch (e) {
      return left(Failure(e.message)); // fpdart: Failure específico
    } catch (e) {
      return left(Failure(e.toString())); // fpdart: Failure genérico
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

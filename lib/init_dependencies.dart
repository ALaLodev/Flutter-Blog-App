// Instancia global del Service Locator
import 'package:blogapp/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:blogapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:blogapp/features/auth/domain/usecase/current_user.dart';
import 'package:blogapp/features/auth/domain/usecase/user_login.dart';
import 'package:blogapp/features/auth/domain/usecase/user_logout.dart';
import 'package:blogapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:blogapp/features/blog/domain/usecases/delete_blog.dart';
import 'package:blogapp/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blogapp/features/blog/domain/usecases/upload_blog.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: 'insert your url here',
    anonKey: 'insert your anon key here',
  );

  // Registramos SupabaseClient como un Singleton externo
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // 1. Data Source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserLogout(serviceLocator()));

  // 2. Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  // 3. Use Case
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  // 4. BLoC
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      userLogout: serviceLocator(),
    ),
  );
}

void _initBlog() {
  // 1. Data Source
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(serviceLocator()),
  );

  // 2. Repository
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(serviceLocator()),
  );

  // 3. Use Case
  serviceLocator.registerFactory(() => UploadBlog(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllBlogs(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteBlog(serviceLocator()));

  // 4. BLoC
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlog: serviceLocator(),
      getAllBlogs: serviceLocator(),
      deleteBlog: serviceLocator(),
    ),
  );
}

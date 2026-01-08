import 'package:blogapp/core/theme/app_theme.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:blogapp/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()..add(AuthIsUserLoggedIn()),
        ),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // 1. Si está logueado -> Ve al Blog
            if (state is AuthSuccess) {
              return const BlogPage();
            }
            // 2. Si está pensando -> Muestra cargando
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // 3. Si no hay nadie o falló -> Ve al Login
            return const LoginPage();
          },
        ),
      ),
    );
  }
}

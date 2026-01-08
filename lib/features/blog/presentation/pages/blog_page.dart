import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blogapp/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    // ¡DISPARAMOS EL EVENTO AL INICIAR LA PANTALLA!
    context.read<BlogBloc>().add(BlogGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route()).then((value) {
                if (context.mounted) {
                  context.read<BlogBloc>().add(BlogGetAll());
                }
              });
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthEventInitial) {
            // Si volvemos al estado inicial, navegamos al Login y borramos el historial
            Navigator.pushAndRemoveUntil(
              context,
              LoginPage.route(),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BlogGetAllSuccess) {
              final currentUserId =
                  (context.read<AuthBloc>().state as AuthSuccess).user.id;

              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    // Un truco para alternar colores de las tarjetas
                    color: index % 3 == 0
                        ? AppPallete.gradient1
                        : index % 3 == 1
                        ? AppPallete.gradient2
                        : AppPallete.gradient3,
                    currentUserId: currentUserId,
                    onDelete: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete Blog'),
                            content: const Text(
                              'Are you sure you wat to delete this blog?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 1. Disparar el evento de borrar
                                  context.read<BlogBloc>().add(
                                    BlogDelete(blog.id),
                                  );
                                  // 2. Cerrar el diálogo
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            }

            if (state is BlogFailure) {
              return Center(child: Text(state.error));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

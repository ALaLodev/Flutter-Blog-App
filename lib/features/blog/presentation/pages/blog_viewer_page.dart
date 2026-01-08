import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/core/utils/calculate_reading_time.dart';
import 'package:blogapp/core/utils/format_date.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));

  final Blog blog;

  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Título
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Información (Autor y Fecha)
                Text(
                  'By ${blog.posterName}', // Aquí ponemos el nombre del autor
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min read',
                  style: const TextStyle(
                    color: AppPallete.greyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Imagen del Blog
                // Usamos ClipRRect para bordes redondeados
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl, // <--- Aquí cargamos la URL de Supabase
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Por si la imagen falla o no carga
                      return Container(
                        height: 250,
                        color: AppPallete.greyColor,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // 4. Contenido del Blog
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

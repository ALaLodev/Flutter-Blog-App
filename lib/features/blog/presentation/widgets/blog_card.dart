import 'package:blogapp/core/utils/calculate_reading_time.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  // Añadimos el callback para cuando se pulse borrar
  final VoidCallback? onDelete;
  // Añadimos el ID del usuario actual para saber si mostrar el icono
  final String currentUserId;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
    this.onDelete,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner =
        currentUserId ==
        blog.posterId; // Comprobamos si somos el dueño del blog

    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categorías (Tags)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label: Text(e),
                          backgroundColor:
                              Colors.black12, // Color de fondo del chip
                          side: BorderSide
                              .none, // Quitamos el borde del chip para que se vea más limpio
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            // Título
            Text(
              blog.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            // Tiempo de lectura (calculado a ojo: 1 min cada 10 palabras xD)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${calculateReadingTime(blog.content)} min read'),

                if (isOwner)
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

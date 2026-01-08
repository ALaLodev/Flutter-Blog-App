import 'dart:io';

import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/models/blog_model.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

final class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required String posterName,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        // 1. Generamos un ID único y la fecha actual
        id: const Uuid().v1(), // Genera un ID único
        posterId: posterId,
        posterName: posterName,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      // 2. Subimos la imagen usando el ID del blog
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      // 3. Actualizamos el modelo con la URL real
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      // 4. Subimos el blog completo a la base de datos
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBlog(String blogId) async {
    try {
      await blogRemoteDataSource.deleteBlog(blogId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

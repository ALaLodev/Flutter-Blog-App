import 'dart:io';
import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();

  Future<void> deleteBlog(String blogId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs') // Nombre de la tabla en Supabase
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      // 1. Subir la imagen al bucket 'blog_images'
      // Usamos el ID del blog como nombre de archivo para que sea único
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);

      // 2. Obtener la URL pública para guardarla después en la base de datos
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      // Pedimos TODOS los blogs a Supabase
      final blogs = await supabaseClient.from('blogs').select('*');

      // Convertimos la lista de JSONs a lista de BlogModels
      return blogs.map((blog) => BlogModel.fromJson(blog)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteBlog(String blogId) async {
    try {
      await supabaseClient.from('blogs').delete().eq('id', blogId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

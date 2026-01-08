import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

final class DeleteBlog implements UseCase<void, DeleteBlogParams> {
  final BlogRepository blogRepository;

  DeleteBlog(this.blogRepository);

  @override
  Future<Either<Failure, void>> call(DeleteBlogParams params) async {
    return await blogRepository.deleteBlog(params.blogId);
  }
}

final class DeleteBlogParams {
  final String blogId;

  DeleteBlogParams({required this.blogId});
}

class Blog {
  final String id;
  final String posterId; // ID del usuario que lo creó
  final String posterName;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  Blog({
    required this.id,
    required this.posterId,
    required this.posterName,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });
}

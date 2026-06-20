import '../../domain/entities/comment.dart';
import 'author_model.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.content,
    required super.author,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as int,
      content: map['content'] as String,
      author: AuthorModel.fromMap(map['user']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

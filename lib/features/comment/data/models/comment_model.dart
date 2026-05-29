import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/comment/domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.content,
    required super.user,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'user': user.toMap(),
      'created_at': createdAt,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as int,
      content: map['content'] as String,
      user: UserModel.fromMap(map['user']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

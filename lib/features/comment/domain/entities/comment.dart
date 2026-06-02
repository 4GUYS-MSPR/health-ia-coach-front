import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user_model.dart';

class Comment extends Equatable {
  final int id;
  final String content;
  final UserModel user;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.content,
    required this.user,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    content,
    user,
    createdAt,
  ];
}

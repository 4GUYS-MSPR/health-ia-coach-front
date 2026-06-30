import 'package:equatable/equatable.dart';

import 'author.dart';

class Comment extends Equatable {
  final int id;
  final String content;
  final Author author;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    content,
    author,
    createdAt,
  ];
}

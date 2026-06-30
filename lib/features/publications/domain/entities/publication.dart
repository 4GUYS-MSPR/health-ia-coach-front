import 'package:equatable/equatable.dart';

import 'author.dart';

enum PublicationType {
  image(1, 'Photo'),
  video(2, 'Vidéo'),
  ;

  final int value;
  final String label;

  const PublicationType(this.value, this.label);

  static PublicationType fromValue(int value) {
    return PublicationType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PublicationType.image,
    );
  }
}

class Publication extends Equatable {
  final int id;
  final PublicationType type;
  final String? image;
  final String? video;
  final String description;
  final Author author;
  final int likes;
  final int comments;
  final bool hasLiked;
  final bool hasCommented;

  const Publication({
    required this.id,
    required this.type,
    this.image,
    this.video,
    required this.description,
    required this.author,
    required this.likes,
    required this.comments,
    required this.hasLiked,
    required this.hasCommented,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    image,
    video,
    description,
    author,
    likes,
    comments,
    hasLiked,
    hasCommented,
  ];
}

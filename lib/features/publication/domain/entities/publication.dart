import 'package:equatable/equatable.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';

class Publication extends Equatable {
  final int id;
  final PublicationType type;
  final String? image;
  final String? video;
  final String description;
  final UserModel user;
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
    required this.user,
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
    user,
    likes,
    comments,
    hasLiked,
    hasCommented,
  ];
}

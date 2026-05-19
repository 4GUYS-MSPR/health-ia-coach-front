import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';

class PublicationModel extends Publication {
  const PublicationModel({
    required super.id,
    required super.type,
    super.image,
    super.video,
    required super.description,
    required super.user,
    required super.likes,
    required super.comments,
    required super.hasLiked,
    required super.hasCommented,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.value,
      'image': image,
      'video': video,
      'description': description,
      'likes': likes,
      'comments': comments,
      'hasLiked': hasLiked,
      'hasCommented': hasCommented,
    };
  }

  factory PublicationModel.fromMap(Map<String, dynamic> map) {
    return PublicationModel(
      id: map['id'] as int,
      type: PublicationType.fromValue(map['type'] as int),
      image: map['image'] as String?,
      video: map['video'] as String?,
      description: map['description'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      hasLiked:  map['has_liked'] as bool,
      hasCommented:  map['has_commented'] as bool,
    );
  }
}

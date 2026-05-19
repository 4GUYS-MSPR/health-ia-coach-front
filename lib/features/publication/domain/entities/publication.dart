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

  const Publication({
    required this.id,
    required this.type,
    this.image,
    this.video,
    required this.description,
    required this.user
  });

  @override
  List<Object?> get props => [id, type, image, video, description, user];
}

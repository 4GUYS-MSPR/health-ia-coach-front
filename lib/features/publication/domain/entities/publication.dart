import 'package:equatable/equatable.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';

class Publication extends Equatable {
  final int id;
  final PublicationType type;
  final String? image;
  final String? video;
  final String description;

  const Publication({
    required this.id,
    required this.type,
    this.image,
    this.video,
    required this.description,
  });

  @override
  List<Object?> get props => [id, type, image, video, description];
}

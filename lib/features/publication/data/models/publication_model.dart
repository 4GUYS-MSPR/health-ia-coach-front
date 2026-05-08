import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';

class PublicationModel extends Publication {
  const PublicationModel({
    required super.id,
    required super.type,
    super.image,
    super.video,
    required super.description,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.value,
      'image': image,
      'video': video,
      'description': description,
    };
  }

  factory PublicationModel.fromMap(Map<String, dynamic> map) {
    return PublicationModel(
      id: map['id'] as int,
      type: PublicationType.fromValue(map['type'] as int),
      image: map['image'] as String?,
      video: map['video'] as String?,
      description: map['description'] as String,
    );
  }
}
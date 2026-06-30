import 'package:equatable/equatable.dart';

import '../../../../core/shared/models/enum_item_model.dart';
import 'body_part.dart';
import 'equipment.dart';
import 'muscle.dart';

class Exercice extends Equatable {
  final int id;
  final String imageUrl;
  final String createAt;
  final EnumItemModel? category;
  final List<BodyPart> bodyParts;
  final List<Equipment> equipments;
  final List<Muscle> secondaryMuscles;
  final List<Muscle> targetMuscles;

  const Exercice({
    required this.id,
    required this.imageUrl,
    required this.createAt,
    this.category,
    this.bodyParts = const [],
    this.equipments = const [],
    this.secondaryMuscles = const [],
    this.targetMuscles = const [],
  });

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    createAt,
    // category,
    bodyParts,
    equipments,
    secondaryMuscles,
    targetMuscles,
  ];
}

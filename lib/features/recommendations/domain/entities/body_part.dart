import 'package:equatable/equatable.dart';

class BodyPart extends Equatable {
  final int id;
  final String name;

  const BodyPart({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

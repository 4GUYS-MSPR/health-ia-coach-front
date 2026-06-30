import 'package:equatable/equatable.dart';

class Equipment extends Equatable {
  final int id;
  final String name;

  const Equipment({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

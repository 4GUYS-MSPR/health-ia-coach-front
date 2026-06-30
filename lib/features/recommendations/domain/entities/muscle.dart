import 'package:equatable/equatable.dart';

class Muscle extends Equatable {
  final int id;
  final String name;

  const Muscle({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
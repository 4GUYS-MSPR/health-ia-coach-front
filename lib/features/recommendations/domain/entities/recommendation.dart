import 'package:equatable/equatable.dart';

import 'exercice.dart';

class Recommendation extends Equatable {
  final String text;
  final List<Exercice> exercices;

  const Recommendation({
    required this.text,
    required this.exercices,
  });

  @override
  List<Object?> get props => [
    text,
    exercices,
  ];
}
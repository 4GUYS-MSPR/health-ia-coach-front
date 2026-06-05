import 'package:equatable/equatable.dart';

class DetectedFood extends Equatable {
  final String name;
  final double confidence;

  const DetectedFood({
    required this.name,
    required this.confidence,
  });

  @override
  List<Object?> get props => [
    name,
    confidence,
  ];
}

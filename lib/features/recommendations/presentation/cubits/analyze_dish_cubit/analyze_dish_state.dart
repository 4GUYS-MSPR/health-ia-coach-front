import 'package:equatable/equatable.dart';
import '../../../domain/entities/dish_analysis.dart';

abstract class AnalyzeDishState extends Equatable {
  const AnalyzeDishState();

  @override
  List<Object?> get props => [];
}

class AnalyzeDishInitial extends AnalyzeDishState {}

class AnalyzeDishLoading extends AnalyzeDishState {
  final String? imagePath;

  const AnalyzeDishLoading({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class AnalyzeDishSuccess extends AnalyzeDishState {
  final DishAnalysis analysis;
  final String? imagePath;

  const AnalyzeDishSuccess({
    required this.analysis,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [analysis, imagePath];
}

class AnalyzeDishFailure extends AnalyzeDishState {
  final String message;
  final String? imagePath;

  const AnalyzeDishFailure({
    required this.message,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [message, imagePath];
}

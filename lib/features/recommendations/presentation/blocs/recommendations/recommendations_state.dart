part of 'recommendations_bloc.dart';

abstract class RecommendationsState extends Equatable {
  const RecommendationsState();

  @override
  List<Object?> get props => [];
}

class RecommendationsInitial extends RecommendationsState {}

class RecommendationsLoading extends RecommendationsState {
  final String? imagePath;

  const RecommendationsLoading({
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
    imagePath,
  ];
}

class RecommendationsLoaded extends RecommendationsState {
  final DishAnalysis analysis;
  final String? imagePath;

  const RecommendationsLoaded({
    required this.analysis,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
    analysis,
    imagePath,
  ];
}

class RecommendationsSuccess extends RecommendationsState {
  final String output;
  
  const RecommendationsSuccess({
    required this.output,
  });

  @override
  List<Object?> get props => [
    output,
  ];
}

class RecommendationsFailure extends RecommendationsState {
  final String message;
  final String? imagePath;

  const RecommendationsFailure({
    required this.message,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
    message,
    imagePath,
  ];
}

import 'package:equatable/equatable.dart';

abstract class AiRecommendationState extends Equatable {
  const AiRecommendationState();

  @override
  List<Object?> get props => [];
}

class AiRecommendationInitial extends AiRecommendationState {}

class AiRecommendationLoading extends AiRecommendationState {}

class AiRecommendationSuccess extends AiRecommendationState {
  final String output;

  const AiRecommendationSuccess({required this.output});

  @override
  List<Object?> get props => [output];
}

class AiRecommendationFailure extends AiRecommendationState {
  final String message;

  const AiRecommendationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

part of 'recommendations_bloc.dart';

abstract class RecommendationsEvent extends Equatable {
  const RecommendationsEvent();

  @override
  List<Object> get props => [];
}

class AnalyzeDishRequested extends RecommendationsEvent {
  final PlatformFile image;

  const AnalyzeDishRequested({
    required this.image,
  });

  @override
  List<Object> get props => [
    image,
  ];
}

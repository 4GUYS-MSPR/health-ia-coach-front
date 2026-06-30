import 'package:bloc/bloc.dart';

import '../../../../../core/usecases/no_params.dart';
import '../../../domain/usecases/recommendations_request.dart';
import 'ai_recommendation_state.dart';

class AiRecommendationCubit extends Cubit<AiRecommendationState> {
  final RecommendationsRequestUsecase recommendationsRequestUsecase;

  AiRecommendationCubit({required this.recommendationsRequestUsecase})
      : super(AiRecommendationInitial());

  Future<void> getRecommendation() async {
    emit(AiRecommendationLoading());

    final result = await recommendationsRequestUsecase(NoParams()).run();

    result.fold(
      (failure) => emit(
        AiRecommendationFailure(
          message: failure.debugMessage ?? "An unknown error occurred",
        ),
      ),
      (output) => emit(
        AiRecommendationSuccess(
          output: output,
        ),
      ),
    );
  }
}

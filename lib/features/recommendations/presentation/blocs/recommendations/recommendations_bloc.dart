import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/entities/dish_analysis.dart';
import '../../../domain/usecases/analyze_dish_usecase.dart';

part 'recommendations_event.dart';
part 'recommendations_state.dart';

class RecommendationsBloc extends Bloc<RecommendationsEvent, RecommendationsState> {
  final AnalyzeDishUsecase analyzeDishUsecase;

  RecommendationsBloc({
    required this.analyzeDishUsecase,
  }) : super(RecommendationsInitial()) {
    on<AnalyzeDishRequested>(_onAnalyzeDishRequested);
  }

  Future<void> _onAnalyzeDishRequested(
    AnalyzeDishRequested event,
    Emitter<RecommendationsState> emit,
  ) async {
    emit(RecommendationsLoading(imagePath: event.image.path));

    final result = await analyzeDishUsecase(AnalyzeDishParams(image: event.image));

    result.fold(
      (failure) => emit(
        RecommendationsFailure(
          message: failure.message,
          imagePath: event.image.path,
        ),
      ),
      (analysis) => emit(
        RecommendationsLoaded(
          analysis: analysis,
          imagePath: event.image.path,
        ),
      ),
    );
  }
}

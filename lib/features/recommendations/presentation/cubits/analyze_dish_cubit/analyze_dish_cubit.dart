import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/usecases/analyze_dish_usecase.dart';
import 'analyze_dish_state.dart';

class AnalyzeDishCubit extends Cubit<AnalyzeDishState> {
  final AnalyzeDishUsecase analyzeDishUsecase;

  AnalyzeDishCubit({required this.analyzeDishUsecase})
      : super(AnalyzeDishInitial());

  Future<void> analyzeDish(PlatformFile image) async {
    emit(AnalyzeDishLoading(imagePath: image.path));

    final result = await analyzeDishUsecase(AnalyzeDishParams(image: image)).run();

    result.fold(
      (failure) => emit(
        AnalyzeDishFailure(
          message: failure.debugMessage ?? "An unknown error occurred",
          imagePath: image.path,
        ),
      ),
      (analysis) => emit(
        AnalyzeDishSuccess(
          analysis: analysis,
          imagePath: image.path,
        ),
      ),
    );
  }
}

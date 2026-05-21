import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';
import 'package:health_ia_care/features/comment/domain/usecases/get_all.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentGetAll getAll;

  CommentBloc({
    required this.getAll,
  }) : super(CommentInitial()) {
    on<CommentGetAllEvent>(_onCommentGetAll);
  }

  Future<void> _onCommentGetAll(
    CommentGetAllEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(CommentLoading());

    final result = await getAll(
      CommentGetAllParams(
        publicationId: event.publicationId,
      ),
    );

    result.fold(
      (failure) => emit(CommentFailure(message: failure.message)),
      (r) => emit(CommentSuccess(comments: r)),
    );
  }
}

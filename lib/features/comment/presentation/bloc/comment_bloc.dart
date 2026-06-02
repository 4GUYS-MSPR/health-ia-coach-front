import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/comment_model.dart';
import '../../domain/usecases/create.dart';
import '../../domain/usecases/get_all.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentGetAll getAll;
  final CommentCreate create;

  CommentBloc({
    required this.getAll,
    required this.create,
  }) : super(CommentInitial()) {
    on<CommentGetAllEvent>(_onCommentGetAll);
    on<CommentCreateEvent>(_onCommentCreate);
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

  Future<void> _onCommentCreate(
    CommentCreateEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(CommentCreateLoading());

    final result = await create(
      CommentCreateParams(
        publicationId: event.publicationId,
        content: event.content,
      ),
    );

    result.fold(
      (failure) => emit(CommentFailure(message: failure.message)),
      (r) => emit(CommentCreateSuccess(comment: r)),
    );
  }
}

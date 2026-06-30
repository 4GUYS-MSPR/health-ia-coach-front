import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/comment_model.dart';
import '../../../domain/usecases/create_comment_usecase.dart';
import '../../../domain/usecases/get_all_comments_usecase.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentEvent, CommentState> {
  final CommentGetAll getAll;
  final CommentCreate create;

  CommentsBloc({
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
    ).run();

    result.fold(
      (failure) => emit(CommentFailure(message: failure.toString())),
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
    ).run();

    result.fold(
      (failure) => emit(CommentFailure(message: failure.toString())),
      (r) => emit(CommentCreateSuccess(comment: r)),
    );
  }
}

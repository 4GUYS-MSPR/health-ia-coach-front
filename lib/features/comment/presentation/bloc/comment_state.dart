part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentFailure extends CommentState {
  final String message;

  const CommentFailure({required this.message});
}

class CommentSuccess extends CommentState {
  final List<CommentModel> comments;

  const CommentSuccess({required this.comments});
}

class CommentCreateLoading extends CommentState {}

class CommentCreateSuccess extends CommentState {
  final CommentModel comment;

  const CommentCreateSuccess({required this.comment});
}

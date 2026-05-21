part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentGetAllEvent extends CommentEvent {
  final int publicationId;

  const CommentGetAllEvent({
    required this.publicationId,
  });
}

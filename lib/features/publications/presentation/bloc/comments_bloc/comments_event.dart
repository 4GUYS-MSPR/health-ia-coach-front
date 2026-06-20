part of 'comments_bloc.dart';

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

class CommentCreateEvent extends CommentEvent {
  final int publicationId;
  final String content;

  const CommentCreateEvent({
    required this.publicationId,
    required this.content,
  });
}

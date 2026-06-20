part of 'publications_bloc.dart';

abstract class PublicationsEvent extends Equatable {
  const PublicationsEvent();

  @override
  List<Object> get props => [];
}

class AddPublicationsEvent extends PublicationsEvent {
  final PublicationType type;
  final String description;
  final PlatformFile media;

  const AddPublicationsEvent({
    required this.type,
    required this.description,
    required this.media,
  });

  @override
  List<Object> get props => [type, description, media];
}

class GetPublicationsEvent extends PublicationsEvent {}

class PublicationsSetLikedEvent extends PublicationsEvent {
  final bool liked;
  final int id;

  const PublicationsSetLikedEvent({
    required this.liked,
    required this.id,
  });
}

part of 'publication_bloc.dart';

abstract class PublicationState extends Equatable {
  const PublicationState();

  @override
  List<Object> get props => [];
}

class PublicationInitial extends PublicationState {}

class PublicationLoading extends PublicationState {}

class PublicationFailure extends PublicationState {
  final String message;
  const PublicationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPublicationSuccess extends PublicationState {
  final Publication publicationPosted;
  const AddPublicationSuccess({required this.publicationPosted});

  @override
  List<Object> get props => [publicationPosted];
}

class GetPublicationsSuccess extends PublicationState {
  final List<PublicationModel> publications;
  const GetPublicationsSuccess({required this.publications});

  @override
  List<Object> get props => [publications];
}

class GetPublicationFailure extends PublicationState {
  final String message;
  const GetPublicationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class PublicationSetLikedLoading extends PublicationState {}

class PublicationSetLikedSuccess extends PublicationState {
  final PublicationModel publication;

  const PublicationSetLikedSuccess({required this.publication});
}

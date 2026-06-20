part of 'publications_bloc.dart';

abstract class PublicationsState extends Equatable {
  const PublicationsState();

  @override
  List<Object> get props => [];
}

class PublicationsInitial extends PublicationsState {}

class PublicationsLoading extends PublicationsState {}

class PublicationsFailure extends PublicationsState {
  final String message;
  const PublicationsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPublicationSuccess extends PublicationsState {
  final Publication publicationPosted;
  const AddPublicationSuccess({required this.publicationPosted});

  @override
  List<Object> get props => [publicationPosted];
}

class GetPublicationsSuccess extends PublicationsState {
  final List<PublicationModel> publications;
  const GetPublicationsSuccess({required this.publications});

  @override
  List<Object> get props => [publications];
}

class GetPublicationsFailure extends PublicationsState {
  final String message;
  const GetPublicationsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class PublicationsSetLikedLoading extends PublicationsState {}

class PublicationsSetLikedSuccess extends PublicationsState {
  final PublicationModel publication;

  const PublicationsSetLikedSuccess({required this.publication});
}

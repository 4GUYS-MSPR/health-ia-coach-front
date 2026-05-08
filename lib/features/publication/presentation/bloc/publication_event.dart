part of 'publication_bloc.dart';

abstract class PublicationEvent extends Equatable {
  const PublicationEvent();

  @override
  List<Object> get props => [];
}

class AddPublicationEvent extends PublicationEvent {
  final PublicationType type;    
  final String description;
  final PlatformFile media;      

  const AddPublicationEvent({
    required this.type,
    required this.description,
    required this.media,
  });

  @override
  List<Object> get props => [type, description, media];
}
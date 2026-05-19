import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/publication_model.dart';
import '../../domain/entities/publication.dart';
import '../../domain/entities/publication_type.dart';
import '../../domain/usecases/add_publication_usecase.dart';
import '../../domain/usecases/get_all_publications_usecase.dart';
import '../../domain/usecases/set_liked_usecase.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  final AddPublicationUsecase addPublication;
  final GetPublicationsUsecase getPublications;
  final SetLikedUsecase setLiked;

  PublicationBloc({
    required this.addPublication,
    required this.getPublications,
    required this.setLiked,
  }) : super(PublicationInitial()) {
    on<AddPublicationEvent>(_onAddPublication);
    on<GetPublicationsEvent>(_onGetPublications);
    on<PublicationSetLikedEvent>(_onSetLiked);
  }

  Future<void> _onAddPublication(
    AddPublicationEvent event,
    Emitter<PublicationState> emit,
  ) async {
    emit(PublicationLoading());

    final result = await addPublication(
      AddPublicationParams(
        type: event.type,
        description: event.description,
        media: event.media,
      ),
    );

    result.fold(
      (failure) => emit(PublicationFailure(message: failure.message)),
      (publication) => emit(AddPublicationSuccess(publicationPosted: publication)),
    );
  }

  Future<void> _onGetPublications(
    GetPublicationsEvent event,
    Emitter<PublicationState> emit,
  ) async {
    emit(PublicationLoading());

    final result = await getPublications(NoParams());

    result.fold(
      (failure) => emit(GetPublicationFailure(message: failure.message)),
      (publications) => emit(GetPublicationsSuccess(publications: publications)),
    );
  }

  Future<void> _onSetLiked(
    PublicationSetLikedEvent event,
    Emitter<PublicationState> emit,
  ) async {
    emit(PublicationSetLikedLoading());

    final result = await setLiked(
      SetLikedParams(
        liked: event.liked,
        id: event.id,
      ),
    );

    result.fold(
      (failure) => emit(PublicationFailure(message: failure.message)),
      (publication) => emit(PublicationSetLikedSuccess(publication: publication)),
    );
  }
}

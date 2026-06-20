import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/publication_model.dart';
import '../../../domain/entities/publication.dart';
import '../../../domain/usecases/add_publication_usecase.dart';
import '../../../domain/usecases/get_all_publications_usecase.dart';
import '../../../domain/usecases/set_liked_usecase.dart';

part 'publications_event.dart';
part 'publications_state.dart';

class PublicationsBloc extends Bloc<PublicationsEvent, PublicationsState> {
  final AddPublicationUsecase addPublication;
  final GetPublicationsUsecase getPublications;
  final SetLikedUsecase setLiked;

  PublicationsBloc({
    required this.addPublication,
    required this.getPublications,
    required this.setLiked,
  }) : super(PublicationsInitial()) {
    on<AddPublicationsEvent>(_onAddPublication);
    on<GetPublicationsEvent>(_onGetPublications);
    on<PublicationsSetLikedEvent>(_onSetLiked);
  }

  Future<void> _onAddPublication(
    AddPublicationsEvent event,
    Emitter<PublicationsState> emit,
  ) async {
    emit(PublicationsLoading());

    final result = await addPublication(
      AddPublicationParams(
        type: event.type,
        description: event.description,
        media: event.media,
      ),
    ).run();

    result.fold(
      (failure) => emit(PublicationsFailure(message: failure.toString())),
      (publication) {
        emit(AddPublicationSuccess(publicationPosted: publication));
        add(GetPublicationsEvent());
      },
    );
  }

  Future<void> _onGetPublications(
    GetPublicationsEvent event,
    Emitter<PublicationsState> emit,
  ) async {
    emit(PublicationsLoading());

    final result = await getPublications().run();

    result.fold(
      (failure) => emit(GetPublicationsFailure(message: failure.toString())),
      (publications) => emit(GetPublicationsSuccess(publications: publications)),
    );
  }

  Future<void> _onSetLiked(
    PublicationsSetLikedEvent event,
    Emitter<PublicationsState> emit,
  ) async {
    emit(PublicationsSetLikedLoading());

    final result = await setLiked(
      SetLikedParams(
        liked: event.liked,
        id: event.id,
      ),
    ).run();

    result.fold(
      (failure) => emit(PublicationsFailure(message: failure.toString())),
      (publication) => emit(PublicationsSetLikedSuccess(publication: publication)),
    );
  }
}

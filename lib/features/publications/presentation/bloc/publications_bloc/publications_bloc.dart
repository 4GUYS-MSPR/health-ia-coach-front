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
    // Sauvegarde de l'état actuel pour pouvoir revenir en cas d'erreur
    final previousState = state;

    // Mise à jour optimiste : on modifie la liste localement sans loading
    if (previousState is GetPublicationsSuccess) {
      final optimisticList = previousState.publications.map((pub) {
        if (pub.id != event.id) return pub;
        return pub.copyWith(
          hasLiked: event.liked,
          likes: event.liked ? pub.likes + 1 : pub.likes - 1,
        );
      }).toList();
      emit(GetPublicationsSuccess(publications: optimisticList));
    }

    // Appel API en arrière-plan
    final result = await setLiked(
      SetLikedParams(liked: event.liked, id: event.id),
    ).run();

    result.fold(
      (failure) {
        // Échec : on revient à l'état précédent
        if (previousState is GetPublicationsSuccess) {
          emit(previousState);
        }
      },
      (updatedPublication) {
        // Succès : on synchronise avec la réponse du serveur
        final currentState = state;
        if (currentState is GetPublicationsSuccess) {
          final syncedList = currentState.publications.map((pub) {
            return pub.id == updatedPublication.id ? updatedPublication : pub;
          }).toList();
          emit(GetPublicationsSuccess(publications: syncedList));
        }
      },
    );
  }
}

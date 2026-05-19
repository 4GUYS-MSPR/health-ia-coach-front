import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';
import 'package:health_ia_care/features/publication/domain/usecases/add_publication_usecase.dart';
import 'package:health_ia_care/features/publication/domain/usecases/get_all_publications_usecase.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  final AddPublicationUsecase addPublication;
  final GetPublicationsUsecase getPublications;

  PublicationBloc({required this.addPublication, required this.getPublications}) : super(PublicationInitial()) {
    on<AddPublicationEvent>(_onAddPublication);
    on<GetPublicationsEvent>(_onGetPublications);
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
      (publication) => emit(GetPublicationsSuccess(publications: publication)),
      );
  }
}
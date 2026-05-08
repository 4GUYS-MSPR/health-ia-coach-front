import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';
import 'package:health_ia_care/features/publication/domain/usecases/add_publication_usecase.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  final AddPublicationUsecase addPublication;

  PublicationBloc({required this.addPublication}) : super(PublicationInitial()) {
    on<AddPublicationEvent>(_onAddPublication);
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
}
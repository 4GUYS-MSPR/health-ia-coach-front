import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/publication/data/models/publication_model.dart';

abstract interface class PublicationRemoteDataSource {
  Future<PublicationModel> createPublication({  
    required int type,
    required String description,
    required PlatformFile media,
  });
}

class PublicationRemoteDataSourceImpl implements PublicationRemoteDataSource {
  final Dio dio;
  final String baseUrl;
  final AuthLocalDataSource localDataSource;

  PublicationRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl,
    required this.localDataSource,
  });

  @override
  Future<PublicationModel> createPublication({  
    required int type,
    required String description,
    required PlatformFile media,
  }) async {
    final token = await localDataSource.getToken();
    final headers = token != null && token.isNotEmpty
        ? {'Authorization': 'Bearer $token'}
        : null;

    MultipartFile file;
    if (media.bytes != null) {
      file = MultipartFile.fromBytes(media.bytes!, filename: media.name);
    } else if (media.path != null) {
      file = await MultipartFile.fromFile(media.path!, filename: media.name);
    } else {
      throw Exception('Fichier invalide'); 
    }

    final formData = FormData();
    formData.fields.add(MapEntry('type', type.toString()));
    formData.fields.add(MapEntry('description', description));

    final fieldName = type == 1 ? 'image' : 'video';
    formData.files.add(MapEntry(fieldName, file));

    final response = await dio.post(
      '$baseUrl/publication/',
      data: formData,
      options: Options(headers: headers),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return PublicationModel.fromMap(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Erreur lors de la création: ${response.statusCode}');
    }
  }
}
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../models/publication_model.dart';

abstract interface class PublicationsRemoteDataSource {
  Future<PublicationModel> createPublication({
    required int type,
    required String description,
    required PlatformFile media,
  });

  Future<List<PublicationModel>> getAllPublications();

  Future<PublicationModel> setLiked({
    required bool liked,
    required int id,
  });
}

class PublicationsRemoteDataSourceImpl implements PublicationsRemoteDataSource {
  final Dio dio;

  PublicationsRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<PublicationModel> createPublication({
    required int type,
    required String description,
    required PlatformFile media,
  }) async {
    MultipartFile file;
    if (media.bytes != null) {
      file = MultipartFile.fromBytes(media.bytes!, filename: media.name);
    } else if (media.path != null) {
      final ioFile = io.File(media.path!);
      final bytes = await ioFile.readAsBytes();

      file = MultipartFile.fromBytes(bytes, filename: media.name);
    } else {
      throw Exception('Fichier invalide');
    }

    final formData = FormData();
    formData.fields.add(MapEntry('type', type.toString()));
    formData.fields.add(MapEntry('description', description));

    final fieldName = type == 1 ? 'image' : 'video';
    formData.files.add(MapEntry(fieldName, file));

    final response = await dio.post(
      '/api/publication/',
      data: formData,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return PublicationModel.fromMap(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Erreur lors de la création: ${response.statusCode}');
    }
  }

  @override
  Future<List<PublicationModel>> getAllPublications() async {
    try {
      final response = await dio.get(
        '/api/publication/',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final List results = data['results'] ?? [];

        return results.map((e) => PublicationModel.fromMap(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Erreur lors de la récupération: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PublicationModel> setLiked({
    required bool liked,
    required int id,
  }) async {
    try {
      String endpoint = '/api/publication/$id/like/';
      final request = liked ? dio.post(endpoint) : dio.delete(endpoint);
      final response = await request;

      if ([201, 200].contains(response.statusCode)) {
        return PublicationModel.fromMap(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Erreur lors de la récupération: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

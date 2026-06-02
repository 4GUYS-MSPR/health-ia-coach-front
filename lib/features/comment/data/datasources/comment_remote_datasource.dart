import 'package:dio/dio.dart';

import '../models/comment_model.dart';

abstract interface class CommentRemoteDataSource {
  Future<List<CommentModel>> getAll({required int publicationId});
  Future<CommentModel> create({required int publicationId, required String content});
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final Dio dio;

  CommentRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<CommentModel>> getAll({required int publicationId}) async {
    try {
      final response = await dio.get(
        '/api/publication/$publicationId/comments/',
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((e) => CommentModel.fromMap(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Erreur lors de la récupération: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> create({required int publicationId, required String content}) async {
    try {
      final response = await dio.post(
        '/api/comment/',
        data: {
          'publication_id': publicationId,
          'content': content,
        },
      );

      if (response.statusCode == 201) {
        return CommentModel.fromMap(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Erreur lors de la récupération: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

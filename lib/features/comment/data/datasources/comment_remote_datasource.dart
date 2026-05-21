import 'package:dio/dio.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';

abstract interface class CommentRemoteDataSource {
  Future<List<CommentModel>> getAll({required int publicationId});
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
}

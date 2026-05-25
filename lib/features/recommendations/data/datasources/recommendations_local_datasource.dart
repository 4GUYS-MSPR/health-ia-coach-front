import '../../../../core/logging/logger_mixin.dart';

abstract interface class RecommendationsLocalDatasource {}

class RecommendationsLocalDatasourceImpl
    with LoggerMixin
    implements RecommendationsLocalDatasource {
  @override
  String get loggerName => 'Recommendations.Data.Datasources.RecommendationsLocalDatasource';
}

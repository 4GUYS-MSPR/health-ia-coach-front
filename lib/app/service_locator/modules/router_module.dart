import 'package:get_it/get_it.dart';
import 'package:health_ia_care/app/router/app_router.dart';

void registerRouter(GetIt sl) {
  sl.registerLazySingleton(() => AppRouter());
}

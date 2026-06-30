import 'package:get_it/get_it.dart';

import '../../router/app_router.dart';

void registerRouter(GetIt sl) {
  sl.registerLazySingleton(
    () => AppRouter(
      authBloc: sl(),
    ),
    dispose: (router) => router.dispose(),
  );
}

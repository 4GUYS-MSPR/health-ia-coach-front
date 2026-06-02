import 'package:get_it/get_it.dart';

import '../../../features/theme/theme_cubit.dart';

void registerThemeCubit(GetIt sl) {
  sl.registerLazySingleton(() => ThemeCubit());
}

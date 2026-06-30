import 'package:get_it/get_it.dart';

import '../../../core/shared/cubits/theme_cubit/theme_cubit.dart';

void registerThemeCubit(GetIt sl) {
  sl.registerLazySingleton(() => ThemeCubit());
}

import 'package:get_it/get_it.dart';

import '../../../core/shared/cubits/locale_cubit/locale_cubit.dart';

void registerLocaleCubit(GetIt sl) {
  sl.registerLazySingleton(() => LocaleCubit());
}

import 'package:get_it/get_it.dart';
import 'package:health_ia_care/features/publication/di/publication_injection.dart';
import 'service_locator_core.dart';
import 'service_locator_features.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await registerCoreDependencies(sl);
  await registerFeatureDependencies(sl);
  await registerPublication(sl);
}

import 'package:get_it/get_it.dart';
import 'package:health_ia_care/app/service_locator/service_locator_core.dart';
import 'package:health_ia_care/app/service_locator/service_locator_features.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await registerCoreDependencies(sl);
  await registerFeatureDependencies(sl);
}

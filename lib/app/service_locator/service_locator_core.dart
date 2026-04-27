import 'package:get_it/get_it.dart';
import 'package:health_ia_care/app/service_locator/modules/router_module.dart';

Future<void> registerCoreDependencies(GetIt sl) async {
  // Modules
  registerRouter(sl);
}

import 'package:get_it/get_it.dart';
import 'modules/router_module.dart';

Future<void> registerCoreDependencies(GetIt sl) async {
  // Modules
  registerRouter(sl);
}

import 'package:get_it/get_it.dart';

import 'init/dotenv_init.dart';
import 'init/logger_init.dart';
import 'modules/router_module.dart';

Future<void> registerCoreDependencies(GetIt sl) async {
  // Inits
  await initDotenv(sl);
  await initLogger(sl);

  // Modules
  registerRouter(sl);
}

import 'package:flutter/material.dart';

import 'app/main_app.dart';
import 'app/service_locator/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MainApp());
}

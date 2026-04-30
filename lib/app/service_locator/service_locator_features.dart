import 'package:get_it/get_it.dart';
import 'package:health_ia_care/features/auth/di/auth_injection.dart';

Future<void> registerFeatureDependencies(GetIt sl) async {
  registerAuth(sl);
}

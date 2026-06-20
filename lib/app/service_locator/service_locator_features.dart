import 'package:get_it/get_it.dart';

import '../../features/auth/di/auth_injection.dart';
import '../../features/profile/di/profile_injection.dart';
import '../../features/publications/di/publications_injection.dart';
import '../../features/recommendations/di/recommentations_injection.dart';

Future<void> registerFeatureDependencies(GetIt sl) async {
  registerAuth(sl);
  registerProfile(sl);
  await registerRecommendations(sl);
  await registerPublicationsFeature(sl);
}

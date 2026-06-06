import 'package:get_it/get_it.dart';
import 'package:health_ia_care/features/auth/di/auth_injection.dart';
import 'package:health_ia_care/features/profile/di/profile_injection.dart';

import '../../features/comment/di/comment_injection.dart';
import '../../features/publication/di/publication_injection.dart';
import '../../features/recommendations/di/recommentations_injection.dart';

Future<void> registerFeatureDependencies(GetIt sl) async {
  registerAuth(sl);
  registerProfile(sl);
  await registerPublication(sl);
  await registerComment(sl);
  await registerRecommendations(sl);
}

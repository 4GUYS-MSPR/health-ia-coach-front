import 'package:go_router/go_router.dart';

import '../../core/theme/shared/pages/app_view.dart';
import '../../core/theme/shared/pages/error_page.dart';
import '../../core/theme/shared/pages/home_page.dart';
import '../../core/theme/shared/pages/profil_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import 'app_routes.dart';

class AppRouter {
  GoRouter get router => _goRouter;

  final _goRouter = GoRouter(
    initialLocation: AppRoutes.login,
    errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profil,
                builder: (context, state) => const ProfilPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

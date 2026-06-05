import 'package:go_router/go_router.dart';
import 'package:health_ia_care/features/publication/presentation/pages/add_publication_page.dart';
import 'package:health_ia_care/features/publication/presentation/pages/publication_list_page.dart';

import '../../core/shared/pages/app_view.dart';
import '../../core/shared/pages/error_page.dart';
import '../../features/profile/presentation/pages/profil_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/recommendations/presentation/pages/recommendations_page.dart';
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
      GoRoute(
        path: AppRoutes.publication,
        name: 'publication',
        builder: (context, state) => const AddPublicationPage(),
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
                builder: (context, state) => const PublicationListPage(),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/recommendations',
                name: AppRoutes.recommendations,
                builder: (context, state) => RecommendationsPage(),
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

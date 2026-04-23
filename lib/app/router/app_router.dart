import 'package:go_router/go_router.dart';
import 'package:health_ia_care/app/router/app_routes.dart';
import 'package:health_ia_care/core/theme/shared/pages/error_page.dart';
import 'package:health_ia_care/core/theme/shared/pages/home_page.dart';
import 'package:health_ia_care/core/theme/shared/pages/app_view.dart';
import 'package:health_ia_care/core/theme/shared/pages/profil_page.dart';



class AppRouter {
  GoRouter get router => _goRouter;

  final _goRouter = GoRouter(
    initialLocation: AppRoutes.home,
    errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
        return AppView(
          navigationShell: navigationShell);
      },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomePage(),
              )
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profil,
                builder: (context, state) => const ProfilPage(),
              )
            ]
          )
        ]
          )
    ]
  );
}
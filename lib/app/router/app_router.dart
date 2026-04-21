import 'package:go_router/go_router.dart';
import 'package:health_ia_care/app/router/app_routes.dart';
import 'package:health_ia_care/core/theme/shared/pages/error_page.dart';
import 'package:health_ia_care/core/theme/shared/pages/home_page.dart';

class AppRouter {
  GoRouter get router => _goRouter;

  final _goRouter = GoRouter(
    initialLocation: AppRoutes.root,
    errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      GoRoute(
        path: AppRoutes.root, 
        redirect: (context, state) => AppRoutes.home),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      )
    ]
  );
}
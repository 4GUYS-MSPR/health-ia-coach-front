import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../core/logging/logger_mixin.dart';
import '../../core/shared/pages/app_view.dart';
import '../../core/shared/pages/not_found_page.dart';
import '../../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/profile/presentation/pages/profil_page.dart';
import '../../features/publications/presentation/pages/add_publication_page.dart';
import '../../features/publications/presentation/pages/publication_list_page.dart';
import '../../features/recommendations/presentation/pages/recommendations_page.dart';
import 'app_routes.dart';
import 'go_router_refresh_stream.dart';
import 'guest_go_route.dart';
import 'protected_go_route.dart';

class AppRouter with LoggerMixin {
  final AuthBloc _authBloc;
  late final GoRouterRefreshStream _routerRefreshStream;

  AppRouter({
    required AuthBloc authBloc,
  }) : _authBloc = authBloc {
    _routerRefreshStream = GoRouterRefreshStream(_authBloc.stream);
  }

  @override
  String get loggerName => 'App.Router.AppRouter';

  GoRouter get router => _goRouter;

  late final _goRouter = GoRouter(
    initialLocation: '/home',
    errorBuilder: _buildErrorPage,
    refreshListenable: _routerRefreshStream,
    routes: [
      ..._authRoutes,
      ProtectedGoRoute(
        path: '/publication',
        name: AppRoutes.publication,
        builder: (context, state) => const AddPublicationPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              ProtectedGoRoute(
                path: '/home',
                name: AppRoutes.home,
                builder: (context, state) => const PublicationListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              ProtectedGoRoute(
                path: '/recommendations',
                name: AppRoutes.recommendations,
                builder: (context, state) => const RecommendationsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              ProtectedGoRoute(
                path: '/profile',
                name: AppRoutes.profile,
                builder: (context, state) => const ProfilPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  final List<RouteBase> _authRoutes = [
    GoRoute(
      path: '/auth',
      redirect: (context, state) {
        if (state.fullPath == '/auth') {
          return '/auth/login';
        }
        return null;
      },
      routes: [
        GuestGoRoute(
          path: '/login',
          name: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GuestGoRoute(
          path: '/register',
          name: AppRoutes.register,
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    ),
  ];

  Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return NotFoundPage(state: state);
  }

  void dispose() {
    _routerRefreshStream.dispose();
  }
}

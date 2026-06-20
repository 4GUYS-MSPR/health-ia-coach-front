import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class ProtectedGoRoute extends GoRoute {
  final String? redirectPath;

  ProtectedGoRoute({
    required super.path,
    super.name,
    super.builder,
    super.routes,
    super.caseSensitive,
    super.onExit,
    super.pageBuilder,
    super.parentNavigatorKey,
    this.redirectPath,
  }) : super(
         redirect: (BuildContext context, GoRouterState state) {
           final authState = context.read<AuthBloc>().state;

           if (authState is! AuthLoggedInState) {
             final String location = state.uri.toString();

             if (redirectPath != null) {
               return redirectPath;
             }

             if (location == "/home") {
               return '/auth/login';
             } else {
               return '/auth/login?redirectTo=$location';
             }
           }

           return null;
         },
       );
}

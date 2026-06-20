import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class GuestGoRoute extends GoRoute {
  GuestGoRoute({
    required super.path,
    super.name,
    super.builder,
    super.caseSensitive,
    super.onExit,
    super.pageBuilder,
    super.parentNavigatorKey,
    super.routes,
  }) : super(
         redirect: (BuildContext context, GoRouterState state) {
           final authState = context.read<AuthBloc>().state;

           if (authState is AuthLoggedInState) {
             return '/home';
           }
           return null;
         },
       );
}

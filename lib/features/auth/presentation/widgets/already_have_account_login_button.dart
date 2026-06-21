import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';

class AlreadyHaveAccountLoginButton extends StatelessWidget {
  const AlreadyHaveAccountLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.replaceNamed(AppRoutes.login),
      child: const Text("Déjà un compte ? Se connecter"),
    );
  }
}

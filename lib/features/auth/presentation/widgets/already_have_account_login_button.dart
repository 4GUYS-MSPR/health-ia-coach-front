import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/l10n_extension.dart';

class AlreadyHaveAccountLoginButton extends StatelessWidget {
  const AlreadyHaveAccountLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.replaceNamed(AppRoutes.login),
      child: Text(context.l10n.authAlreadyHaveAccountLogin),
    );
  }
}

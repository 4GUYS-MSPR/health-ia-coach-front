import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';

class NoAccountRegisterButton extends StatelessWidget {
  const NoAccountRegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.replaceNamed(AppRoutes.register),
      child: Text("Pas de compte ? S'inscrire"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/l10n_extension.dart';

class NoAccountRegisterButton extends StatelessWidget {
  const NoAccountRegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.replaceNamed(AppRoutes.register),
      child: Text(context.l10n.authNoAccountRegister),
    );
  }
}

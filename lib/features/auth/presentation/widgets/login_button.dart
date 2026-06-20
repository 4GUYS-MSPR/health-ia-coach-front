import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../cubits/login_cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      HapticFeedback.selectionClick();
      context.read<LoginCubit>().submitRequested();
    }

    final buttonStyle = ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
      ),
    );

    return FilledButton.icon(
      onPressed: onPressed,
      style: buttonStyle,
      icon: Icon(Symbols.login),
      label: Text("Se connecter"),
    );
  }
}

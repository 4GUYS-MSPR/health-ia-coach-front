import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../widgets/theme_switch_button.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSucess){
            context.replace('/login');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Center(
              child: Column(
                children: [
                  Image.asset('assets/profile.png', width: 200.0),

                  SwitchThemeButton(),
                  ElevatedButton(onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                  }, child: Text('Se déconnecter')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

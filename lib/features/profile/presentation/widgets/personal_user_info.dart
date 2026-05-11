import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/info_text.dart';

class PersonalUserInfo extends StatelessWidget {
  const PersonalUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess){
          final user = state.user;
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoText(text: 'Nom de compte:',),
                    InfoText(text: user.username),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoText(text: 'Prénom:',),
                    InfoText(text: user.firstname),
                  ],
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoText(text: 'Nom:',),
                    InfoText(text: user.lastname),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is AuthLoading){
          return const Center(child: CircularProgressIndicator());
        }
        return const SizedBox.shrink();
      },
    );
  }
}

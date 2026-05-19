import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import 'info_text.dart';

class PersonalUserInfo extends StatelessWidget {
  final UserModel user;
  const PersonalUserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final user = state.user;
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoText(
                      text: context.l10n.profileMyAccountAccountNameLabel,
                    ),
                    InfoText(text: user.username),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoText(
                      text: context.l10n.profileMyAccountFirstnameLabel,
                    ),
                    InfoText(text: user.firstname),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoText(
                      text: context.l10n.profileMyAccountLastnameLabel,
                    ),
                    InfoText(text: user.lastname),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const SizedBox.shrink();
      },
    );
  }
}

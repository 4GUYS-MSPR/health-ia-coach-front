import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';

class CloseModalButton extends StatelessWidget {
  const CloseModalButton({super.key});

  @override
  Widget build(BuildContext context) {
    void closeModal() {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess || state is ProfileMemberUpdateSuccess) {
          closeModal();
        }
      },
      child: IconButton(
        icon: const Icon(Icons.cancel),
        iconSize: 40,
        onPressed: closeModal,
      ),
    );
  }
}
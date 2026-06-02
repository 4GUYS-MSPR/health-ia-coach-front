import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/core/extensions/l10n_extension.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/close_modal_button.dart';

class PersonalUserModalForm extends StatefulWidget {
  final UserModel user;
  const PersonalUserModalForm({
    super.key, 
    required this.user
    });

  @override
  State<PersonalUserModalForm> createState() => _PersonalUserModalFormState();
}

class _PersonalUserModalFormState extends State<PersonalUserModalForm> {
  late final TextEditingController usernameController;
  late final TextEditingController firstnameController;
  late final TextEditingController lastnameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    firstnameController = TextEditingController(text: widget.user.firstname);
    lastnameController = TextEditingController(text: widget.user.lastname);
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseModalButton()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.l10n.profileMyAccountEditModalTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                spacing: 50,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom d\'utilisateur',
                        style: Theme.of(context).textTheme.headlineSmall
                      ),
                      TextFormField(
                        controller: usernameController,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prénom',
                      style: Theme.of(context).textTheme.headlineSmall
                      ),
                      TextFormField(
                        controller: firstnameController,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom',
                      style: Theme.of(context).textTheme.headlineSmall
                      ),
                      TextFormField(
                        controller: lastnameController,
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: (){
                      final username = usernameController.text;
                      final firstname = firstnameController.text;
                      final lastname = lastnameController.text;
                      context.read<ProfileBloc>().add(
                        ProfileUpdateRequestEvent(username: username, firstname: firstname, lastname: lastname)
                      );
                    }, 
                    child: Text('Modifier')
                    )
                ]
              ),
            ),
          ]
        ),
      ),
    ),
  );
}
}
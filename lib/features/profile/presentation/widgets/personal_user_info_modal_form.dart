import 'package:flutter/material.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/close_modal_button.dart';


class PersonalUserInfoModalForm extends StatefulWidget {
  const PersonalUserInfoModalForm({super.key});

  @override
  State<PersonalUserInfoModalForm> createState() => _PersonalUserInfoModalFormState();
}

class _PersonalUserInfoModalFormState extends State<PersonalUserInfoModalForm> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseModalButton()
              ],
            ),
            Text('Mes infos'),
          ],
        ),
      )
    );
  }
}
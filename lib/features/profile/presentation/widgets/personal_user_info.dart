import 'package:flutter/material.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/info_text.dart';

class PersonalUserInfo extends StatelessWidget {
  const PersonalUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoText(
                text:'Nom de compte'
              ),
              InfoText(
                text:'FirstName'
              ),
              InfoText(
                text:'lastName'
              )
            ],
          ),
        ],
      )
    );
}
}
import 'package:flutter/widgets.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';
import 'package:health_ia_care/features/profile/presentation/helpers/profil_utils.dart';

import 'package:health_ia_care/features/profile/presentation/widgets/info_text.dart';

class DisplayMemberInfo extends StatelessWidget {
  final MemberModel member;
  const DisplayMemberInfo({
    required this.member,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoText(text: 'Age'),
                InfoText(text: 'BMI'),
                InfoText(text: 'Pourcentage de gras'),
                InfoText(text: 'Taille'),
                InfoText(text: 'Poid'),
                InfoText(text: 'Frequence d\'entraînement'),
                InfoText(text: 'Sexe'),
                InfoText(text: 'Niveau'),
                InfoText(text: 'Abonnement'),
              ],
            ),
            Column(
              children: [
                InfoText(text: member.age.toString()),
                InfoText(text: member.bmi.toString()),
                InfoText(text: '${member.fatPercentage.toString()}%'),
                InfoText(text: '${convertHeight(member.height).toString()}cm'),
                InfoText(text: '${member.weight.toString()}kg'),
                InfoText(text: '${member.workoutFrequency.toString()}/s'),
                InfoText(text: member.gender?.value ?? '_'),
                InfoText(text: member.level?.value ?? '_'),
                InfoText(text: member.subscription?.value ?? '_'),
              ],
            )
          ],
        )
      ],
    );
  }
}
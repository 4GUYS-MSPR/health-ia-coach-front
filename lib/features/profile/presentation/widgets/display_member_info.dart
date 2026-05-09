import 'package:flutter/widgets.dart';

import 'package:health_ia_care/features/profile/presentation/widgets/info_text.dart';



class DisplayMemberInfo extends StatelessWidget {
  const DisplayMemberInfo({super.key});

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
                InfoText(text: 'Objectifs'),
              ],
            ),
            Column(
              children: [
                InfoText(text: '18'),
                InfoText(text: '20'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                InfoText(text: '30'),
                
              ],
            )
          ],
        )
      ],
    );
  }
}
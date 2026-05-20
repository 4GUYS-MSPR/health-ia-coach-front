import 'package:flutter/widgets.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';
import 'package:health_ia_care/features/profile/presentation/helpers/profil_utils.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/display_info_member.dart';

const List<String> genderList = <String>['MALE', 'FEMALE', 'NOT SPECIFIED'];
const List<String> levelList = <String>['BEGINNER', 'INTERMEDIATE', 'EXPERT'];
class DisplayMemberInfo extends StatelessWidget {
  final MemberModel member;
  const DisplayMemberInfo({
    required this.member,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
          DisplayInfoMember(label: 'Age', value: member.age.toString()),
          DisplayInfoMember(label: 'BMI', value: member.bmi.toString()),
          DisplayInfoMember(label: 'Pourcentage de gras', value: '${member.fatPercentage.toString()}%'),
          DisplayInfoMember(label: 'Taille', value: '${convertHeight(member.height).toString()}cm'),
          DisplayInfoMember(label: 'Poid', value: '${member.weight.toString()}kg'),
          DisplayInfoMember(label: 'Frequence d\'entraînement', value: '${member.workoutFrequency.toString()}/s'),
          DisplayInfoMember(label: 'Sexe', value: member.level?.value ?? "-"),
          DisplayInfoMember(label: 'Abonnement', value: member.subscription?.value ?? "-"),
          ],
        ),
      ],
    );
  }
}

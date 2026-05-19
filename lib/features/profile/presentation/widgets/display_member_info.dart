import 'package:flutter/widgets.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../data/models/member_model.dart';
import '../helpers/profil_utils.dart';
import 'display_info_member.dart';

const List<String> genderList = <String>['MALE', 'FEMALE', 'NOT SPECIFIED'];
const List<String> levelList = <String>['BEGINNER', 'INTERMEDIATE', 'EXPERT'];

class DisplayMemberInfo extends StatelessWidget {
  final MemberModel member;
  const DisplayMemberInfo({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            DisplayInfoMember(
              label: context.l10n.profileMyInfosAgeLabel,
              value: member.age.toString(),
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosBmiLabel,
              value: member.bmi.toString(),
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosFatPercentageLabel,
              value: '${member.fatPercentage.toString()}%',
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosSizeLabel,
              value: '${convertHeight(member.height).toString()}cm',
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosWeightLabel,
              value: '${member.weight.toString()}kg',
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosWorkoutFrequencyLabel,
              value: '${member.workoutFrequency.toString()}/s',
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosLevelLabel,
              value: member.level?.value ?? "-",
            ),
            DisplayInfoMember(
              label: context.l10n.profileMyInfosSubscriptionLabel,
              value: member.subscription?.value ?? "-",
            ),
          ],
        ),
      ],
    );
  }
}

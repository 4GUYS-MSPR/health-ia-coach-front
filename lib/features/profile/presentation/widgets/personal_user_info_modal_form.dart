import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/core/extensions/l10n_extension.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/helpers/profil_utils.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/close_modal_button.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/custom_dropdown.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/custom_text_form_field.dart';

const List<String> genderList = ['MALE', 'FEMALE', 'NOT SPECIFIED'];
const List<String> levelList = ['BEGINNER', 'INTERMEDIATE', 'EXPERT'];

class PersonalUserInfoModalForm extends StatefulWidget {
  final MemberModel member;
  const PersonalUserInfoModalForm({super.key, required this.member});

  @override
  State<PersonalUserInfoModalForm> createState() => _PersonalUserInfoModalFormState();
}

class _PersonalUserInfoModalFormState extends State<PersonalUserInfoModalForm> {
  late final TextEditingController ageController;
  late final TextEditingController bmiController;
  late final TextEditingController fatPerceentageController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;
  late final TextEditingController workoutFrequencyController;
  late final TextEditingController subscriptionController;
  late String? selectedGender;
  late String? selectedLevel;

  @override
  void initState() {
    ageController = TextEditingController(text: widget.member.age.toString());
    bmiController = TextEditingController(text: widget.member.bmi.toString());
    fatPerceentageController = TextEditingController(text: widget.member.fatPercentage.toString());
    heightController = TextEditingController(text: widget.member.height.toString());
    weightController = TextEditingController(text: widget.member.weight.toString());
    workoutFrequencyController = TextEditingController(
      text: widget.member.workoutFrequency.toString(),
    );
    selectedLevel = widget.member.level?.value;
    selectedGender = widget.member.gender?.value;
    subscriptionController = TextEditingController(text: widget.member.subscription?.value);
    super.initState();
  }

  @override
  void dispose() {
    ageController.dispose();
    bmiController.dispose();
    fatPerceentageController.dispose();
    heightController.dispose();
    weightController.dispose();
    workoutFrequencyController.dispose();
    subscriptionController.dispose();
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
                children: [CloseModalButton()],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.profileMyInfosEditModalTitle,
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
                    CustomTextFormField(
                      label: context.l10n.profileMyInfosAgeLabel,
                      controller: ageController,
                    ),
                    CustomTextFormField(
                      label: context.l10n.profileMyInfosBmiLabel,
                      controller: bmiController,
                    ),
                    CustomTextFormField(
                      label: context.l10n.profileMyInfosFatPercentageLabel,
                      controller: fatPerceentageController,
                    ),
                    CustomTextFormField(
                      label: context.l10n.profileMyInfosSizeLabel,
                      controller: heightController,
                    ),
                    CustomTextFormField(
                      label: context.l10n.profileMyInfosWorkoutFrequencyLabel,
                      controller: workoutFrequencyController,
                    ),
                    CustomDropDown(
                      label: context.l10n.profileMyInfosGenderLabel,
                      selectedValue: selectedGender,
                      listChoice: genderList,
                    ),
                    CustomDropDown(
                      label: context.l10n.profileMyInfosLevelLabel,
                      selectedValue: selectedLevel,
                      listChoice: levelList,
                    ),
                    CustomTextFormField(
                      label: context.l10n.profileMyInfosSubscriptionLabel,
                      controller: subscriptionController,
                    ),
                    SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        final age = ageController.text;
                        final bmi = bmiController.text;
                        final fatPercentage = fatPerceentageController.text;
                        final height = heightController.text;
                        final weight = weightController.text;
                        final workoutFrequency = workoutFrequencyController.text;
                        final level = selectedLevel;
                        final gender = selectedGender;
                        final subscription = subscriptionController.text;
                        context.read<ProfileBloc>().add(
                          ProfileMemberUpdateRequestEvent(
                            age: int.parse(age),
                            bmi: double.parse(bmi),
                            fatPercentage: double.parse(fatPercentage),
                            height: double.parse(height),
                            weight: double.parse(weight),
                            workoutFrequency: int.parse(workoutFrequency),
                            gender: convertGenderToInt(gender),
                            level: convertLevelToInt(level),
                            subscription: convertSubscriptionToInt(subscription),
                          ),
                        );
                      },
                      child: Text(context.l10n.profileMyInfosEditModalConfirmButtonLabel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

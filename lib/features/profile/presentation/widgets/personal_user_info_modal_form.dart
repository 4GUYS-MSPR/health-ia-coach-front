import 'package:flutter/material.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';
import 'package:health_ia_care/features/profile/presentation/helpers/profil_utils.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/close_modal_button.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/custom_text_form_field.dart';

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
  late final TextEditingController genderController;
  late final TextEditingController levelController;
  late final TextEditingController subscriptionController;

  @override
  void initState() {
    ageController = TextEditingController(text: widget.member.age.toString());
    bmiController = TextEditingController(text: widget.member.bmi.toString());
    fatPerceentageController = TextEditingController(text: widget.member.fatPercentage.toString());
    heightController = TextEditingController(text: widget.member.height.toString());
    weightController = TextEditingController(text: widget.member.weight.toString());
    workoutFrequencyController = TextEditingController(text: widget.member.workoutFrequency.toString());
    genderController = TextEditingController(text: getGenderDisplayLabel(widget.member.gender?.value));
    levelController = TextEditingController(text: widget.member.level.toString());
    subscriptionController = TextEditingController(text: widget.member.subscription.toString());
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
    genderController.dispose();
    levelController.dispose();
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
                      'Modifier mes informations',
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
                    CustomTextFormField(label: 'Age', controller: ageController),
                    CustomTextFormField(label: 'bmi', controller: bmiController),
                    CustomTextFormField(
                      label: 'Pourcentage de gras',
                      controller: fatPerceentageController,
                    ),
                    CustomTextFormField(label: 'Taille', controller: heightController),
                    CustomTextFormField(label: 'Frequence', controller: workoutFrequencyController),
                    CustomTextFormField(label: 'Sexe', controller: genderController),
                    CustomTextFormField(label: 'Niveau', controller: levelController),
                    CustomTextFormField(label: 'Abonnement', controller: subscriptionController),
                    SizedBox(height: 20),
                    FilledButton(onPressed: () {}, child: Text('Modifier')),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../bloc/profile_bloc.dart';

class ProfileInfosSection extends StatefulWidget {
  final Profile profile;
  const ProfileInfosSection({super.key, required this.profile});

  @override
  State<ProfileInfosSection> createState() => _ProfileInfosSectionState();
}

class _ProfileInfosSectionState extends State<ProfileInfosSection> {
  late TextEditingController _ageCtrl;
  late TextEditingController _bmiCtrl;
  late TextEditingController _fatPercentageCtrl;
  late TextEditingController _heightCtrl;
  late TextEditingController _weightCtrl;
  late TextEditingController _workoutFreqCtrl;
  late TextEditingController _levelCtrl;
  late TextEditingController _subscriptionCtrl;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _ageCtrl = TextEditingController(text: widget.profile.age.toString());
    _bmiCtrl = TextEditingController(text: widget.profile.bmi?.toString() ?? "");
    _fatPercentageCtrl = TextEditingController(text: widget.profile.fatPercentage?.toString() ?? "");
    _heightCtrl = TextEditingController(text: widget.profile.height?.toString() ?? "");
    _weightCtrl = TextEditingController(text: widget.profile.weight?.toString() ?? "");
    _workoutFreqCtrl = TextEditingController(text: widget.profile.workoutFrequency.toString());
    _levelCtrl = TextEditingController(text: widget.profile.level?.value ?? "");
    _subscriptionCtrl = TextEditingController(text: widget.profile.subscription?.value ?? "");
  }

  @override
  void didUpdateWidget(covariant ProfileInfosSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile != widget.profile) {
      _ageCtrl.text = widget.profile.age.toString();
      _bmiCtrl.text = widget.profile.bmi?.toString() ?? "";
      _fatPercentageCtrl.text = widget.profile.fatPercentage?.toString() ?? "";
      _heightCtrl.text = widget.profile.height?.toString() ?? "";
      _weightCtrl.text = widget.profile.weight?.toString() ?? "";
      _workoutFreqCtrl.text = widget.profile.workoutFrequency.toString();
      _levelCtrl.text = widget.profile.level?.value ?? "";
      _subscriptionCtrl.text = widget.profile.subscription?.value ?? "";
    }
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _bmiCtrl.dispose();
    _fatPercentageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _workoutFreqCtrl.dispose();
    _levelCtrl.dispose();
    _subscriptionCtrl.dispose();
    super.dispose();
  }

  void _onSave() {
    context.read<ProfileBloc>().add(
      UpdateProfileEvent(
        UpdateProfileParams(
          age: int.tryParse(_ageCtrl.text),
          bmi: double.tryParse(_bmiCtrl.text),
          fatPercentage: double.tryParse(_fatPercentageCtrl.text),
          height: double.tryParse(_heightCtrl.text),
          weight: double.tryParse(_weightCtrl.text),
          workoutFrequency: int.tryParse(_workoutFreqCtrl.text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const Icon(Symbols.id_card),
        shape: const Border.fromBorderSide(BorderSide.none),
        title: Text(context.l10n.profileMyInfosSectionTitle),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        children: [
          Column(
            children: [
              TextFormField(
                controller: _ageCtrl,
                decoration: InputDecoration(
                  labelText: context.l10n.profileMyInfosAgeLabel,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _bmiCtrl,
                decoration: InputDecoration(
                  labelText: context.l10n.profileMyInfosBmiLabel,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fatPercentageCtrl,
                decoration: InputDecoration(
                  labelText: context.l10n.profileMyInfosFatPercentageLabel,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _heightCtrl,
                decoration: InputDecoration(
                  labelText: context.l10n.profileMyInfosSizeLabel,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _weightCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyInfosWeightLabel,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _workoutFreqCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyInfosWorkoutFrequencyLabel,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _levelCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyInfosLevelLabel,
            ),
            readOnly: true,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _subscriptionCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyInfosSubscriptionLabel,
            ),
            readOnly: true,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _onSave,
              icon: const Icon(Symbols.save),
              label: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}

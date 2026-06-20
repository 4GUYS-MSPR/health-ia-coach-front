import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../bloc/profile_bloc.dart';

class ProfileAccountSection extends StatefulWidget {
  final Profile profile;
  const ProfileAccountSection({super.key, required this.profile});

  @override
  State<ProfileAccountSection> createState() => _ProfileAccountSectionState();
}

class _ProfileAccountSectionState extends State<ProfileAccountSection> {
  late TextEditingController _usernameCtrl;
  late TextEditingController _firstnameCtrl;
  late TextEditingController _lastnameCtrl;

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController(text: widget.profile.username);
    _firstnameCtrl = TextEditingController(text: widget.profile.firstname);
    _lastnameCtrl = TextEditingController(text: widget.profile.lastname);
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _firstnameCtrl.dispose();
    _lastnameCtrl.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProfileAccountSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile != widget.profile) {
      if (_usernameCtrl.text != widget.profile.username) {
        _usernameCtrl.text = widget.profile.username;
      }
      if (_firstnameCtrl.text != widget.profile.firstname) {
        _firstnameCtrl.text = widget.profile.firstname;
      }
      if (_lastnameCtrl.text != widget.profile.lastname) {
        _lastnameCtrl.text = widget.profile.lastname;
      }
    }
  }

  void _onSave() {
    context.read<ProfileBloc>().add(
      UpdateProfileEvent(
        UpdateProfileParams(
          username: _usernameCtrl.text.isNotEmpty ? _usernameCtrl.text : null,
          firstname: _firstnameCtrl.text.isNotEmpty ? _firstnameCtrl.text : null,
          lastname: _lastnameCtrl.text.isNotEmpty ? _lastnameCtrl.text : null,
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
        leading: const Icon(Symbols.account_circle),
        shape: const Border.fromBorderSide(BorderSide.none),
        title: Text(context.l10n.profileMyAccountSectionTitle),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        children: [
          TextFormField(
            controller: _usernameCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyAccountAccountNameLabel,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _firstnameCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyAccountFirstnameLabel,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastnameCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.profileMyAccountLastnameLabel,
            ),
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

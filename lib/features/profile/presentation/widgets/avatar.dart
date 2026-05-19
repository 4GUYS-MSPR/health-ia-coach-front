import 'package:flutter/material.dart';
import 'package:health_ia_care/core/secrets/app_secrets.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/auth/helpers/auth_utils.dart';

class Avatar extends StatefulWidget {
  final UserModel user;
  const Avatar({
    required this.user,
    super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: ClipRRect(
        borderRadius: .circular(100.0),
        child: widget.user.avatar != null ? 
          SizedBox(
            height: 120,
            width: 120,
            child: Image.network(
              AppSecrets.baseUrl + widget.user.avatar!),
          ) :
          Container(
            alignment: .center,
            height: 120,
            width: 120,
            padding: EdgeInsets.all(12),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              style: TextStyle(
                fontSize: 48
                ),
              getNameInitials(widget.user.firstname, widget.user.lastname))),
      ),
    );
  }
}
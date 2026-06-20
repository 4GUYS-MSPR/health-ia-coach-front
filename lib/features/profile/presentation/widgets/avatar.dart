import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../../../core/utils/string_utils.dart';
import '../../domain/entities/profile.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    required this.profile,
    this.onTapEdit,
    super.key,
  });

  final Profile profile;
  final VoidCallback? onTapEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        fit: .expand,
        clipBehavior: .none,
        children: [
          Container(
            padding: .all(2),
            decoration: BoxDecoration(
              shape: .circle,
              color: context.colorScheme.outline,
            ),
            child: CircleAvatar(
              foregroundImage: profile.avatarUrl != null
                  ? NetworkImage(AppSecrets.baseUrl + profile.avatarUrl!)
                  : null,
              child: Text(
                getNameInitials(profile.firstname, profile.lastname),
                style: context.textTheme.displayMedium,
              ),
            ),
          ),
          if (onTapEdit != null)
            Positioned(
              bottom: 0,
              right: -12,
              child: IconButton.filledTonal(
                onPressed: onTapEdit,
                icon: Icon(
                  Symbols.camera_alt,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

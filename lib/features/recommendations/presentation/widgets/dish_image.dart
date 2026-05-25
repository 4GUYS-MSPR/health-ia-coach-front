import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

import '../../../../core/extensions/theme_extension.dart';

class DishImage extends StatelessWidget {
  const DishImage({
    super.key,
    required this.imagePath,
  });

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? imageProvider;
    if (imagePath != null) {
      try {
        final file = File(imagePath!);
        if (file.existsSync()) {
          imageProvider = FileImage(file);
        }
      } catch (_) {
        imageProvider = null;
      }
    }

    return ZoAnimatedGradientBorder(
      borderRadius: 12,
      borderThickness: 3,
      animationDuration: const Duration(seconds: 2),
      gradientColor: [
        context.colorScheme.primaryFixed,
        context.colorScheme.secondaryFixed,
        context.colorScheme.tertiaryFixed,
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: imageProvider != null
              ? Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                )
              : Container(
                  color: context.colorScheme.,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: context.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

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
    final imageProvider = imagePath != null
        ? FileImage(File(imagePath!)) as ImageProvider<Object>

    return ZoAnimatedGradientBorder(
      borderRadius: 12,
      borderThickness: 3,
      animationDuration: Duration(seconds: 2),
      gradientColor: [
        context.colorScheme.primaryFixed,
        context.colorScheme.secondaryFixed,
        context.colorScheme.tertiaryFixed,
      ],
      child: Container(
        clipBehavior: .antiAlias,
        height: 200,
        width: .infinity,
        decoration: BoxDecoration(borderRadius: .circular(12)),
        child: Image(
          image: imageProvider,
          fit: .cover,
        ),
      ),
    );
  }
}

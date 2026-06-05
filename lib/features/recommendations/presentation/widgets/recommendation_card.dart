import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_extension.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  final String? recommendation;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: .zero,
      color: context.colorScheme.surfaceContainerHigh,
      child: Container(
        width: .infinity,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              "Recommandation",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              recommendation ?? "En attente d'une entrée",
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/theme_extension.dart';

class FiabilityCard extends StatelessWidget {
  const FiabilityCard({
    super.key,
    required this.reliability,
  });

  final double reliability;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: .zero,
      clipBehavior: .antiAlias,
      color: context.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              context.l10n.recommendationReliabilityIndex,
              style: context.textTheme.titleMedium?.copyWith(fontWeight: .bold),
            ),
            Text(
              context.l10n.recommendationReliabilityDescription,
              style: context.textTheme.labelSmall,
            ),
            SizedBox(height: 8),
            Card.outlined(
              margin: .zero,
              child: LinearProgressIndicator(
                value: reliability,
                trackGap: 0,
                // ignore: deprecated_member_use
                year2023: false,
                minHeight: 16,
                borderRadius: .circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

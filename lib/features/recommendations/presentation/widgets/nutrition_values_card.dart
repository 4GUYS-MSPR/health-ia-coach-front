import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_extension.dart';

class NutritionValuesCard extends StatelessWidget {
  const NutritionValuesCard({
    super.key,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  final String calories;
  final String proteins;
  final String carbs;
  final String fats;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: .zero,
      clipBehavior: .antiAlias,
      color: context.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: .infinity,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(
                "Valeurs nutritionnelles",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
              SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisExtent: 80,
                children: [
                  Card(
                    color: context.colorScheme.primaryContainer,
                    child: Column(
                      mainAxisAlignment: .center,
                      spacing: 4,
                      children: [
                        Text(
                          calories,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: .bold,
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          "calories",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: context.colorScheme.secondaryContainer,
                    child: Column(
                      spacing: 4,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          proteins,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: .bold,
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        Text(
                          "protéines",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: context.colorScheme.secondaryContainer,
                    child: Column(
                      spacing: 4,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          carbs,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: .bold,
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        Text(
                          "glucides",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: context.colorScheme.secondaryContainer,
                    child: Column(
                      mainAxisAlignment: .center,
                      spacing: 4,
                      children: [
                        Text(
                          fats,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: .bold,
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        Text(
                          "lipides",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

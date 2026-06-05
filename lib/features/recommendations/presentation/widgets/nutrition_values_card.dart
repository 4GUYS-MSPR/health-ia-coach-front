import 'package:flutter/material.dart';
import '../../../../core/extensions/theme_extension.dart';

class NutritionValuesCard extends StatelessWidget {
  const NutritionValuesCard({
    super.key,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    this.label,
    this.category,
    this.mealType,
  });

  final String calories;
  final String proteins;
  final String carbs;
  final String fats;
  final String? label;
  final String? category;
  final String? mealType;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: context.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Valeurs nutritionnelles",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (label != null) ...[
                const SizedBox(height: 4),
                Text(
                  label!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (category != null || mealType != null) ...[
                const SizedBox(height: 4),
                Row(
                  spacing: 8,
                  children: [
                    if (category != null)
                      Chip(
                        label: Text(
                          category!,
                          style: context.textTheme.labelSmall,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    if (mealType != null)
                      Chip(
                        label: Text(
                          mealType!,
                          style: context.textTheme.labelSmall,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisExtent: 80,
                children: [
                  _MacroCard(
                    value: calories,
                    label: "calories",
                    color: context.colorScheme.primaryContainer,
                    textColor: context.colorScheme.onPrimaryContainer,
                  ),
                  _MacroCard(
                    value: proteins,
                    label: "protéines",
                    color: context.colorScheme.secondaryContainer,
                    textColor: context.colorScheme.onSecondaryContainer,
                  ),
                  _MacroCard(
                    value: carbs,
                    label: "glucides",
                    color: context.colorScheme.secondaryContainer,
                    textColor: context.colorScheme.onSecondaryContainer,
                  ),
                  _MacroCard(
                    value: fats,
                    label: "lipides",
                    color: context.colorScheme.secondaryContainer,
                    textColor: context.colorScheme.onSecondaryContainer,
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

class _MacroCard extends StatelessWidget {
  const _MacroCard({
    required this.value,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String value;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
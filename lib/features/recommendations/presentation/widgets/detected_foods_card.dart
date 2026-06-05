import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../domain/entities/detected_food.dart';

class DetectedFoodsCard extends StatelessWidget {
  const DetectedFoodsCard({
    super.key,
    required this.foods,
  });

  final List<DetectedFood> foods;

  double _clampRatio(double value) => value.clamp(0, 1).toDouble();

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: .zero,
      color: context.colorScheme.surfaceContainerHigh,
      child: Container(
        padding: .all(8),
        width: .infinity,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "Aliments détectés",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
              ),
            ),
            if (foods.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Aucun aliment détecté",
                  style: context.textTheme.bodySmall,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return Card(
                    margin: .zero,
                    child: ListTile(
                      dense: true,
                      title: Text(food.name),
                      subtitle: LinearProgressIndicator(
                        value: _clampRatio(food.confidence),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

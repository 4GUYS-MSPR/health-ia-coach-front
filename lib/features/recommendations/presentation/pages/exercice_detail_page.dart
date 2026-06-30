import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../domain/entities/exercice.dart';

class ExerciceDetailPage extends StatelessWidget {
  final Exercice exercice;

  const ExerciceDetailPage({super.key, required this.exercice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.exerciceDetailPrefix(exercice.id)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'exercice_image_${exercice.id}',
              child: Image.network(
                exercice.imageUrl,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: context.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Symbols.fitness_center,
                      size: 64,
                      color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (exercice.category != null) ...[
                    Text(
                      context.l10n.exerciceCategoryLabel,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(exercice.category!.value),
                    const SizedBox(height: 16),
                  ],
                  if (exercice.bodyParts.isNotEmpty) ...[
                    Text(
                      context.l10n.exerciceBodyPartsLabel,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: exercice.bodyParts.map((bp) => Chip(label: Text(bp.name))).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (exercice.equipments.isNotEmpty) ...[
                    Text(
                      context.l10n.exerciceEquipmentsLabel,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: exercice.equipments.map((eq) => Chip(label: Text(eq.name))).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (exercice.targetMuscles.isNotEmpty) ...[
                    Text(
                      context.l10n.exerciceTargetMusclesLabel,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: exercice.targetMuscles.map((tm) => Chip(label: Text(tm.name))).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (exercice.secondaryMuscles.isNotEmpty) ...[
                    Text(
                      context.l10n.exerciceSecondaryMusclesLabel,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: exercice.secondaryMuscles.map((sm) => Chip(label: Text(sm.name))).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

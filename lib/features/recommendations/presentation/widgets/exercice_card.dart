import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../domain/entities/exercice.dart';
import '../pages/exercice_detail_page.dart';

class ExerciceCard extends StatelessWidget {
  const ExerciceCard({super.key, required this.exercice});

  final Exercice exercice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: context.colorScheme.shadow.withValues(alpha: 0.2),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciceDetailPage(exercice: exercice),
            ),
          );
        },
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'exercice_image_${exercice.id}',
                      child: Image.network(
                        exercice.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: context.colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Symbols.fitness_center,
                              size: 48,
                              color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          context.l10n.exerciceDetailPrefix(exercice.id), // Translated label
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Symbols.sports_gymnastics,
                          size: 14,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${context.l10n.recommendationCategoryLabel} ${exercice.category?.value ?? ''}",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

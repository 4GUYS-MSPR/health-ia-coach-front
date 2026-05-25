import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../domain/entities/detected_food.dart';
import '../blocs/recommendations/recommendations_bloc.dart';
import '../widgets/detected_foods_card.dart';
import '../widgets/dish_image.dart';
import '../widgets/fiability_card.dart';
import '../widgets/nutrition_values_card.dart';
import '../widgets/photo_capture_widget.dart';
import '../widgets/recommendation_card.dart';

class RecommendationsCompactLayout extends StatelessWidget {
  const RecommendationsCompactLayout({super.key});

  String _formatValue(double? value, {String suffix = ''}) {
    if (value == null) {
      return '—';
    }
    return '${value.toStringAsFixed(0)}$suffix';
  }

  double _clampRatio(double? value) {
    if (value == null) {
      return 0;
    }
    return value.clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendationsBloc, RecommendationsState>(
      listener: (context, state) {
        if (state is RecommendationsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final analysis = state is RecommendationsLoaded ? state.analysis : null;
        final foods = analysis?.foods ?? const <DetectedFood>[];
        final nutrition = analysis?.nutrition;
        final imagePath = switch (state) {
          RecommendationsLoading(:final imagePath) => imagePath,
          RecommendationsLoaded(:final imagePath) => imagePath,
          RecommendationsFailure(:final imagePath) => imagePath,
          _ => null,
        };

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 8,
                  mainAxisSize: .min,
                  children: [
                    DishImage(imagePath: imagePath),
                    RecommendationCard(
                      recommendation: analysis?.recommendation,
                    ),
                    DetectedFoodsCard(foods: foods),
                    NutritionValuesCard(
                      calories: _formatValue(nutrition?.calories),
                      proteins: _formatValue(nutrition?.proteinsG, suffix: 'g'),
                      carbs: _formatValue(nutrition?.carbsG, suffix: 'g'),
                      fats: _formatValue(nutrition?.fatsG, suffix: 'g'),
                    ),
                    FiabilityCard(
                      reliability: _clampRatio(analysis?.reliability),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<PlatformFile>(
                MaterialPageRoute(
                  builder: (context) => const PhotoCapturePage(),
                ),
              );
              if (!context.mounted || result == null) {
                return;
              }
              context.read<RecommendationsBloc>().add(AnalyzeDishRequested(image: result));
            },
            child: Icon(
              Symbols.add_a_photo,
              fill: 1,
            ),
          ),
        );
      },
    );
  }
}

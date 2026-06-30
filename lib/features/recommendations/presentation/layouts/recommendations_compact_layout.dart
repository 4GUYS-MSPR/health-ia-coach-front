import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/extensions/l10n_extension.dart';

import '../../domain/entities/detected_food.dart';
import '../cubits/analyze_dish_cubit/analyze_dish_cubit.dart';
import '../cubits/analyze_dish_cubit/analyze_dish_state.dart';
import '../widgets/detected_foods_card.dart';
import '../widgets/dish_image.dart';
import '../widgets/fiability_card.dart';
import '../widgets/nutrition_values_card.dart';
import '../widgets/photo_capture_widget.dart';

class RecommendationsCompactLayout extends StatelessWidget {
  const RecommendationsCompactLayout({super.key});

  String _formatValue(double? value, {String suffix = ''}) {
    if (value == null) return '—';
    return '${value.toStringAsFixed(0)}$suffix';
  }

  double _clampRatio(double? value) {
    if (value == null) return 0;
    return value.clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalyzeDishCubit, AnalyzeDishState>(
      listener: (context, state) {
        if (state is AnalyzeDishFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AnalyzeDishLoading;
        final analysis  = state is AnalyzeDishSuccess ? state.analysis : null;
        final foods     = analysis?.foods ?? const <DetectedFood>[];
        final nutrition = analysis?.nutrition;

        final imagePath = switch (state) {
          AnalyzeDishLoading(:final imagePath)  => imagePath,
          AnalyzeDishSuccess(:final imagePath)   => imagePath,
          AnalyzeDishFailure(:final imagePath)  => imagePath,
          _ => null,
        };

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DishImage(imagePath: imagePath),
                        DetectedFoodsCard(foods: foods),
                        NutritionValuesCard(
                          calories: _formatValue(nutrition?.calories),
                          proteins: _formatValue(
                            nutrition?.proteinsG,
                            suffix: 'g',
                          ),
                          carbs: _formatValue(
                            nutrition?.carbsG,
                            suffix: 'g',
                          ),
                          fats: _formatValue(
                            nutrition?.fatsG,
                            suffix: 'g',
                          ),
                          label:    nutrition?.label,
                          category: nutrition?.category,
                          mealType: nutrition?.mealType,
                        ),
                        FiabilityCard(
                          reliability: _clampRatio(analysis?.reliability),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),

                if (isLoading)
                  Container(
                    color: Colors.black45,
                    child:  Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 16,
                        children: [
                          const CircularProgressIndicator(),
                          Text(
                            context.l10n.recommendationGeneratingMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            heroTag: 'recommendations_fab',
            onPressed: isLoading
                ? null
                : () async {
                    final result = await Navigator.of(context).push<PlatformFile>(
                      MaterialPageRoute(
                        builder: (context) => const PhotoCapturePage(),
                      ),
                    );
                    if (!context.mounted || result == null) return;
                    context.read<AnalyzeDishCubit>().analyzeDish(result);
                  },
            child: const Icon(
              Symbols.add_a_photo,
              fill: 1,
            ),
          ),
        );
      },
    );
  }
}
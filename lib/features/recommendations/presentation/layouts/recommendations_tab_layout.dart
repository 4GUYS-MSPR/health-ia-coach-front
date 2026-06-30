import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../cubits/ai_recommendation_cubit/ai_recommendation_cubit.dart';
import '../cubits/ai_recommendation_cubit/ai_recommendation_state.dart';
import '../widgets/exercice_card.dart';

class RecommendationsTabLayout extends StatelessWidget {
  const RecommendationsTabLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AiRecommendationCubit>()..getRecommendation(),
      child: const _RecommendationsTabLayoutContent(),
    );
  }
}

class _RecommendationsTabLayoutContent extends StatelessWidget {
  const _RecommendationsTabLayoutContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AiRecommendationCubit>().getRecommendation();
        },
        child: BlocBuilder<AiRecommendationCubit, AiRecommendationState>(
          builder: (context, state) {
            if (state is AiRecommendationLoading) {
              return _buildLoading(context);
            } else if (state is AiRecommendationSuccess) {
              return _buildSuccess(context, state);
            } else if (state is AiRecommendationFailure) {
              return _buildError(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 16),
          Text(context.l10n.recommendationGeneratingMessage),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, AiRecommendationFailure state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Symbols.error, color: context.colorScheme.error, size: 64),
            const SizedBox(height: 16),
            Text(
              context.l10n.recommendationOopsTitle,
              style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: TextStyle(color: context.colorScheme.error),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, AiRecommendationSuccess state) {
    final recommendation = state.output;
    final hasExercices = recommendation.exercices.isNotEmpty;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Texte Recommandation (Minimalist Style)
                Row(
                  children: [
                    Icon(
                      Symbols.auto_awesome,
                      color: context.colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        context.l10n.recommendationAiCoachTitle,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  recommendation.text,
                  textAlign: .justify,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Section Exercices
                if (hasExercices) ...[
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.recommendationRecommendedExercisesTitle,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        if (hasExercices)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280, // Hauteur du carrousel
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                scrollDirection: Axis.horizontal,
                itemCount: recommendation.exercices.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final exercice = recommendation.exercices[index];
                  return ExerciceCard(exercice: exercice);
                },
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)), // Espace pour le FAB
      ],
    );
  }
}

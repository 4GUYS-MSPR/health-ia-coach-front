import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../cubits/ai_recommendation_cubit/ai_recommendation_cubit.dart';
import '../cubits/ai_recommendation_cubit/ai_recommendation_state.dart';

class ProfileRecommendationSection extends StatelessWidget {
  const ProfileRecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AiRecommendationCubit>()..getRecommendation(),
      child: Builder(
        builder: (context) {
          return Card.filled(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Symbols.auto_awesome,
                        color: context.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Recommendation IA",
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<AiRecommendationCubit, AiRecommendationState>(
                    builder: (context, state) {
                      if (state is AiRecommendationLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is AiRecommendationSuccess) {
                        return Text(state.output);
                      } else if (state is AiRecommendationFailure) {
                        return Text(
                          state.message,
                          style: TextStyle(color: context.colorScheme.error),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: .infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<AiRecommendationCubit>().getRecommendation();
                      },
                      icon: Icon(Symbols.refresh),
                      label: Text("Refresh"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

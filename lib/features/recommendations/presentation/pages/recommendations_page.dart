import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/shared/layouts/responsive_layout_builder.dart';
import '../cubits/analyze_dish_cubit/analyze_dish_cubit.dart';
import '../layouts/recommendations_compact_layout.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AnalyzeDishCubit>(),
      child: ResponsiveLayoutBuilder(
        compact: RecommendationsCompactLayout(),
      ),
    );
  }
}

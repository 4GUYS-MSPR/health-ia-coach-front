import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../cubits/analyze_dish_cubit/analyze_dish_cubit.dart';
import '../layouts/recommendations_compact_layout.dart';
import '../layouts/recommendations_tab_layout.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AnalyzeDishCubit>()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(
              tabs: [
                Tab(text: context.l10n.recommendationTabDish),
                Tab(text: context.l10n.recommendationTabRecommendations),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RecommendationsCompactLayout(),
              RecommendationsTabLayout(),
            ],
          ),
        ),
      ),
    );
  }
}

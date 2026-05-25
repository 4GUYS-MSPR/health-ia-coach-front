import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/shared/layouts/responsive_layout_builder.dart';
import '../blocs/recommendations/recommendations_bloc.dart';
import '../layouts/recommendations_compact_layout.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RecommendationsBloc>(),
      child: ResponsiveLayoutBuilder(
        compact: RecommendationsCompactLayout(),
      ),
    );
  }
}

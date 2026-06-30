import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../app/router/app_routes.dart';
import '../../extensions/l10n_extension.dart';
import '../../extensions/theme_extension.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final bool isPublicationTab = navigationShell.currentIndex == 0;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Symbols.cardiology),
        title: Text(
          "HealthIA Care",
          style: context.textTheme.titleMedium?.copyWith(fontWeight: .bold),
        ),
        titleSpacing: 0,
      ),
      body: navigationShell,
      floatingActionButton: isPublicationTab
          ? FloatingActionButton(
              heroTag: 'app_view_fab',
              onPressed: () => context.push(AppRoutes.publication),
              tooltip: context.l10n.publicationAddAPublicationPageTitle,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.l10n.navigationHomePageLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Symbols.analytics),
            label: context.l10n.recommendationNavigationLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: context.l10n.navigationProfilePageLabel,
          ),
        ],
      ),
    );
  }
}

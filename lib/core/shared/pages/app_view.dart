import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_ia_care/app/router/app_routes.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset('assets/logo.png'),
        ),
        title: Text("HealthIA Care"),
      ),
      body: navigationShell,
      floatingActionButtonLocation: .endFloat,
      floatingActionButton: navigationShell.currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () => context.push<void>(AppRoutes.publication),
              child: Icon(Icons.add_a_photo, color: Colors.white,),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

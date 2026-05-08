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
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [IconButton(onPressed: () {
          context.push<void>(AppRoutes.publication);
        }, icon: Icon(Icons.add_photo_alternate_outlined))],
      ),
      body: navigationShell,
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

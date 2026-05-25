import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Symbols.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.dinner_dining),
            label: "Recommendations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

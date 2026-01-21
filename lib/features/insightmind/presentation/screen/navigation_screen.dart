import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/home_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/setting_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/statistic_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return ScaffoldApp(
      body: switch (selectedIndex) {
        0 => const HomeScreen(),
        1 => const StatisticScreen(),
        2 => const SettingScreen(),
        _ => const HomeScreen(),
      },
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        currentIndex: selectedIndex,
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined, size: 26),
            title: Text(
              "Beranda",
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: color.onSurfaceVariant,
              ),
            ),
            selectedColor: color.primary,
            unselectedColor: color.secondary,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.analytics_outlined, size: 26),
            title: Text(
              "Statistik",
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: color.onSurfaceVariant,
              ),
            ),
            selectedColor: color.primary,
            unselectedColor: color.secondary,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.settings_outlined, size: 26),
            title: Text(
              "Pengaturan",
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: color.onSurfaceVariant,
              ),
            ),
            selectedColor: color.primary,
            unselectedColor: color.secondary,
          ),
        ],
      ),
    );
  }
}

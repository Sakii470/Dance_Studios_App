// lib/presentation/widgets/app_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:mimiqit_app/l10n/generated/l10n.dart'; // Import wygenerowanego pliku
import 'package:mimiqit_app/themes/app_theme.dart';
import 'package:mimiqit_app/themes/app_theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      selectedItemColor: AppTheme.darkTheme.colorScheme.primary,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: S.of(context).studios,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: S.of(context).map,
        ),
      ],
    );
  }
}

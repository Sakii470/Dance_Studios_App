// lib/views/widgets/gradient_background.dart
import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

/// A widget that provides a radial gradient background for its child.
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = true; // Ponieważ mamy tylko darkMode

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: isDarkMode
              ? [
            AppTheme.darkTheme.colorScheme.primary, // Center color
            AppTheme.darkTheme.colorScheme.background, // Outer color
          ]
              : [
            AppTheme.darkTheme.colorScheme.primary,
            AppTheme.darkTheme.colorScheme.background,
          ],
          stops: const [0.6, 1.0],
        ),
      ),
      child: child,
    );
  }
}

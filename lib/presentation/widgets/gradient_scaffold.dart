// lib/views/widgets/gradient_scaffold.dart
import 'package:flutter/material.dart';
import 'gradient_background.dart';

/// A custom Scaffold wrapped in a gradient background.
class GradientScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? drawer;

  const GradientScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Transparent to show gradient
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
      ),
    );
  }
}

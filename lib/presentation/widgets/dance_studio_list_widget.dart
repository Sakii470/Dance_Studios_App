// lib/views/widgets/dance_studio_list_widget.dart
import 'package:flutter/material.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';
import '../../themes/app_theme.dart';

/// A widget that displays a list of DanceStudios in Cards.
/// It reacts to theme changes dynamically using Theme.of(context).
class DanceStudioListWidget extends StatelessWidget {
  final List<DanceStudio> studios;
  final ValueChanged<DanceStudio> onStudioSelected;

  const DanceStudioListWidget({
    required this.studios,
    required this.onStudioSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: studios.length,
      itemBuilder: (context, index) {
        final studio = studios[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // Remove manual color setting
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(
              Icons.location_city,
              color: AppTheme.darkTheme.colorScheme.primary, // Dynamically fetched primary color
            ),
            title: Text(
              studio.name,
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.darkTheme.colorScheme.onSurface, // Dynamically fetched text color
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studio.address,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.darkTheme.colorScheme.onSurface
                        .withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4.0,
                  children: studio.danceStyles
                      .map((style) => Chip(
                    label: Text(
                      style,
                      style: AppTheme.darkTheme.textTheme.bodySmall
                          ?.copyWith(
                        color: AppTheme.darkTheme
                            .colorScheme.onPrimary,
                      ),
                    ),
                    backgroundColor:AppTheme.darkTheme.colorScheme.primary,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ))
                      .toList(),
                ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.darkTheme.colorScheme.primary, // Matches leading icon color
            ),
            onTap: () => onStudioSelected(studio),
          ),
        );
      },
    );
  }
}

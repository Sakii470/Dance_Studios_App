// lib/presentation/pages/dance_studio_details_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimiqit_app/l10n/generated/l10n.dart'; // Import wygenerowanego pliku
import 'package:mimiqit_app/themes/app_theme.dart';
import 'package:mimiqit_app/presentation/widgets/primary_button.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_bloc.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_event.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_state.dart';
import 'package:mimiqit_app/themes/app_theme.dart';

class DanceStudioDetailsView extends StatelessWidget {
  const DanceStudioDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final DanceStudio studio =
    ModalRoute.of(context)!.settings.arguments as DanceStudio;

    return BlocConsumer<DanceStudioBloc, DanceStudioState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).bookingConfirmed),
              content: Text(S.of(context).bookingConfirmationMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).ok),
                ),
              ],
            ),
          );
        } else if (state is BookingError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).errorBookingStudio)),
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is BookingLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(studio.name),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address
                  Text(
                    '${S.of(context).address}: ${studio.address}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  // Dance Styles
                  Text(
                    S.of(context).danceStyles,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: Wrap(
                      spacing: 8.0,
                      children: studio.danceStyles.map((style) {
                        return Chip(
                          label: Text(
                            style,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          backgroundColor:
                          AppTheme.darkTheme.colorScheme.primary,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Description
                  Text(
                    S.of(context).description,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    studio.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  // Book Now Button
                  Center(
                    child: PrimaryButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        // Dispatch the booking event
                        context
                            .read<DanceStudioBloc>()
                            .add(BookDanceStudio(studio));
                      },
                      isLoading: isLoading,
                      child: isLoading
                          ? Text(S.of(context).booking)
                          : Text(S.of(context).bookNow),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

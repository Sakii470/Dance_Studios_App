// lib/presentation/pages/dance_studio_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_bloc.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_event.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_state.dart';
import 'package:mimiqit_app/presentation/widgets/dance_studio_list_widget.dart';
import 'package:mimiqit_app/presentation/widgets/gradient_background.dart';
import 'package:mimiqit_app/themes/app_theme.dart';
import 'package:mimiqit_app/l10n/generated/l10n.dart'; // Import wygenerowanego pliku

class DanceStudioListPage extends StatefulWidget {
  const DanceStudioListPage({super.key});

  @override
  State<DanceStudioListPage> createState() => _DanceStudioListPageState();
}

class _DanceStudioListPageState extends State<DanceStudioListPage> {
  String _selectedDanceStyle = '';
  String _searchQuery = '';
  bool _isSearching = false;
  bool _isFiltering = false;

  // Define a consistent input decoration
  final InputDecoration _inputDecoration = InputDecoration(
    labelText: '', // Will be overridden in build
    labelStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.purpleAccent,
        width: 2,
      ),
    ),
    prefixIcon: const Icon(Icons.search, color: Colors.white),
    filled: true,
    fillColor: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    final DanceStudioBloc danceStudioBloc = context.read<DanceStudioBloc>();

    return GradientBackground(
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: _inputDecoration.copyWith(
                labelText: S.of(context).searchDanceStyles,
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              enabled: !_isFiltering,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _isSearching = value.isNotEmpty;
                  if (_isSearching) {
                    _isFiltering = false;
                  }
                });
                if (_isSearching) {
                  danceStudioBloc.add(SearchDanceStyles(_searchQuery));
                } else {
                  danceStudioBloc.add(const FilterDanceStudios(''));
                }
              },
            ),
          ),
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<DanceStudioBloc, DanceStudioState>(
              builder: (context, state) {
                if (state is DanceStudioLoaded) {
                  final availableDanceStyles = state.danceStyles;

                  return DropdownButtonFormField<String>(
                    decoration: _inputDecoration.copyWith(
                      labelText: S.of(context).filterByDanceStyle,
                      prefixIcon: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                    dropdownColor: Colors.black87,
                    value: _selectedDanceStyle.isEmpty ? null : _selectedDanceStyle,
                    items: [
                      DropdownMenuItem(
                        value: '',
                        child: Text(
                          S.of(context).all,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      ...availableDanceStyles.map(
                            (style) => DropdownMenuItem(
                          value: style,
                          child: Text(
                            style,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                    onChanged: _isSearching
                        ? null
                        : (value) {
                      setState(() {
                        _selectedDanceStyle = value ?? '';
                        _isFiltering = _selectedDanceStyle.isNotEmpty;
                        if (_isFiltering) {
                          _isSearching = false;
                          _searchQuery = '';
                        }
                      });
                      danceStudioBloc.add(FilterDanceStudios(_selectedDanceStyle));
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(height: 16),
          // Dance Studios List
          Expanded(
            child: BlocConsumer<DanceStudioBloc, DanceStudioState>(
              listener: (context, state) {
                if (state is DanceStudioError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is DanceStudioLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DanceStudioLoaded) {
                  if (state.studios.isEmpty) {
                    return Center(child: Text(S.of(context).noStudiosFound));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      danceStudioBloc.add(RefreshDanceStudios());
                    },
                    child: DanceStudioListWidget(
                      studios: state.studios,
                      onStudioSelected: (DanceStudio studio) {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: studio,
                        );
                      },
                    ),
                  );
                } else if (state is DanceStudioError) {
                  return Center(
                    child: Text(
                      '${S.of(context).errorFetchingStudios} ${state.message}',
                    ),
                  );
                }
                return const Center(child: Text('No data available.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

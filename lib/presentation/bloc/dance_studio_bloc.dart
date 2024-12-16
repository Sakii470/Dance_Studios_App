// lib/bloc/dance_studio_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';
import 'dance_studio_event.dart';
import 'dance_studio_state.dart';
import '/domain/i_dance_studio_repository.dart';

class DanceStudioBloc extends Bloc<DanceStudioEvent, DanceStudioState> {
  final IDanceStudioRepository repository;
  List<DanceStudio> _allStudios = [];
  List<String> _allDanceStyles = [];
  String _currentSearchQuery = '';
  String _currentFilterStyle = '';
  int _currentIndex = 0; // Default tab index

  DanceStudioBloc({required this.repository}) : super(DanceStudioInitial()) {
    on<FetchDanceStudios>(_onFetchDanceStudios);
    on<RefreshDanceStudios>(_onRefreshDanceStudios);
    on<FilterDanceStudios>(_onFilterDanceStudios);
    on<SearchDanceStyles>(_onSearchDanceStyles);
    on<ChangeTab>(_onChangeTab);
    on<BookDanceStudio>(_onBookDanceStudio); // Handle booking event
  }

  Future<void> _onFetchDanceStudios(
      FetchDanceStudios event, Emitter<DanceStudioState> emit) async {
    emit(DanceStudioLoading());
    try {
      _allStudios = await repository.getStudios();
      _allDanceStyles = _extractAllDanceStyles(_allStudios);
      emit(DanceStudioLoaded(_applyFilters(), _allDanceStyles, _currentIndex));
    } catch (e) {
      emit(DanceStudioError('Failed to fetch dance studios.'));
    }
  }

  Future<void> _onRefreshDanceStudios(
      RefreshDanceStudios event, Emitter<DanceStudioState> emit) async {
    try {
      _allStudios = await repository.getStudios();
      _allDanceStyles = _extractAllDanceStyles(_allStudios);
      emit(DanceStudioLoaded(_applyFilters(), _allDanceStyles, _currentIndex));
    } catch (e) {
      emit(DanceStudioError('Failed to refresh dance studios.'));
    }
  }

  Future<void> _onFilterDanceStudios(
      FilterDanceStudios event, Emitter<DanceStudioState> emit) async {
    _currentFilterStyle = event.danceStyle;
    _currentSearchQuery = ''; // Reset search query
    emit(DanceStudioLoaded(_applyFilters(), _allDanceStyles, _currentIndex));
  }

  Future<void> _onSearchDanceStyles(
      SearchDanceStyles event, Emitter<DanceStudioState> emit) async {
    _currentSearchQuery = event.query;
    _currentFilterStyle = ''; // Reset filter
    emit(DanceStudioLoaded(_applyFilters(), _allDanceStyles, _currentIndex));
  }

  Future<void> _onChangeTab(
      ChangeTab event, Emitter<DanceStudioState> emit) async {
    _currentIndex = event.newIndex;
    emit(DanceStudioLoaded(_applyFilters(), _allDanceStyles, _currentIndex));
  }

  // New handler for booking
  Future<void> _onBookDanceStudio(
      BookDanceStudio event, Emitter<DanceStudioState> emit) async {
    emit(BookingLoading());
    try {
      await repository.bookDanceStudio(event.studio);
      emit(BookingSuccess('Booking confirmed for ${event.studio.name}!'));
      // Optionally, re-emit the current loaded state
      emit(DanceStudioLoaded(_applyFilters(), _allDanceStyles, _currentIndex));
    } catch (e) {
      emit(BookingError('Failed to book dance studio. Please try again.'));
    }
  }

  List<DanceStudio> _applyFilters() {
    List<DanceStudio> filtered = _allStudios;

    if (_currentFilterStyle.isNotEmpty) {
      filtered = filtered.where((studio) {
        return studio.danceStyles.any((style) =>
            style.toLowerCase().contains(_currentFilterStyle.toLowerCase()));
      }).toList();
    }

    if (_currentSearchQuery.isNotEmpty) {
      filtered = filtered.where((studio) {
        return studio.danceStyles.any((style) =>
            style.toLowerCase().contains(_currentSearchQuery.toLowerCase()));
      }).toList();
    }

    return filtered;
  }

  List<String> _extractAllDanceStyles(List<DanceStudio> studios) {
    final styles = studios
        .expand((studio) => studio.danceStyles)
        .toSet()
        .toList()
      ..sort();
    return styles;
  }
}

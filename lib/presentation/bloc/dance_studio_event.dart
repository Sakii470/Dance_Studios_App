// lib/bloc/dance_studio_event.dart
import 'package:equatable/equatable.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';

abstract class DanceStudioEvent extends Equatable {
  const DanceStudioEvent();

  @override
  List<Object> get props => [];
}

class FetchDanceStudios extends DanceStudioEvent {}

class RefreshDanceStudios extends DanceStudioEvent {}

class FilterDanceStudios extends DanceStudioEvent {
  final String danceStyle;

  const FilterDanceStudios(this.danceStyle);

  @override
  List<Object> get props => [danceStyle];
}

class SearchDanceStyles extends DanceStudioEvent {
  final String query;

  const SearchDanceStyles(this.query);

  @override
  List<Object> get props => [query];
}

class ChangeTab extends DanceStudioEvent {
  final int newIndex;

  const ChangeTab(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}

// New Event for Booking
class BookDanceStudio extends DanceStudioEvent {
  final DanceStudio studio;

  const BookDanceStudio(this.studio);

  @override
  List<Object> get props => [studio];
}

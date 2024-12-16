// lib/bloc/dance_studio_state.dart
import 'package:equatable/equatable.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';

abstract class DanceStudioState extends Equatable {
  const DanceStudioState();

  @override
  List<Object> get props => [];
}

class DanceStudioInitial extends DanceStudioState {}

class DanceStudioLoading extends DanceStudioState {}

class DanceStudioLoaded extends DanceStudioState {
  final List<DanceStudio> studios;
  final List<String> danceStyles;
  final int currentIndex;

  const DanceStudioLoaded(this.studios, this.danceStyles, this.currentIndex);

  @override
  List<Object> get props => [studios, danceStyles, currentIndex];
}

class DanceStudioError extends DanceStudioState {
  final String message;

  const DanceStudioError(this.message);

  @override
  List<Object> get props => [message];
}

// New States for Booking
class BookingLoading extends DanceStudioState {}

class BookingSuccess extends DanceStudioState {
  final String confirmationMessage;

  const BookingSuccess(this.confirmationMessage);

  @override
  List<Object> get props => [confirmationMessage];
}

class BookingError extends DanceStudioState {
  final String errorMessage;

  const BookingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

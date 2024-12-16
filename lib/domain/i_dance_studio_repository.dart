// lib/repositories/i_dance_studio_repository.dart
import 'package:mimiqit_app/data/models/dance_studio.dart';

/// Interface that defines a contract for fetching dance studios.
/// This allows us to implement different data sources (e.g. API, local DB).
abstract class IDanceStudioRepository {
  Future<List<DanceStudio>> getStudios();

  // Method for booking a dance studio
  Future<void> bookDanceStudio(DanceStudio studio);
}

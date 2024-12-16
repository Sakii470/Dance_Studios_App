// lib/models/dance_studio.dart
import 'package:equatable/equatable.dart';

class DanceStudio extends Equatable {
  final String name;
  final String address;
  final List<String> danceStyles;
  final String description;
  final double latitude;
  final double longitude;

  const DanceStudio({
    required this.name,
    required this.address,
    required this.danceStyles,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [name, address, danceStyles, description, latitude, longitude];
}

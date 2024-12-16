// lib/repositories/dance_studio_repository_firestore.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';
import '../../domain/i_dance_studio_repository.dart';

/// This class fetches data from the 'danceStudios' collection in Firestore. This class also send query to booking.
class DanceStudioFirestoreRepository implements IDanceStudioRepository {
 // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  DanceStudioFirestoreRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<DanceStudio>> getStudios() async {
    try {
      // Fetch the entire 'danceStudios' collection
      final querySnapshot = await _firestore.collection('danceStudios').get();

      // Map documents to DanceStudio objects
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return DanceStudio(
          name: data['name'] as String? ?? '',
          address: data['address'] as String? ?? '',
          danceStyles: (data['danceStyles'] as List<dynamic>?)
              ?.map((style) => style as String)
              .toList() ??
              [],
          description: data['description'] as String? ?? '',
          latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
          longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch dance studios: $e');
    }
  }

  @override
  Future<void> bookDanceStudio(DanceStudio studio) async {
    try {
      // Reference to 'bookings' collection
      final bookingsRef = _firestore.collection('bookings');

      // Add a new booking document
      await bookingsRef.add({
        'studioName': studio.name,
        'address': studio.address,
        'danceStyles': studio.danceStyles,
        'description': studio.description,
        'latitude': studio.latitude,
        'longitude': studio.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to book dance studio: $e');
    }
  }
}

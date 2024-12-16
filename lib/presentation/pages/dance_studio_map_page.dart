// lib/views/pages/dance_studio_map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mimiqit_app/presentation/bloc/dance_studio_bloc.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_state.dart';
import 'package:mimiqit_app/data/models/dance_studio.dart';

class DanceStudioMapPage extends StatefulWidget {
  const DanceStudioMapPage({super.key});

  @override
  State<DanceStudioMapPage> createState() => _DanceStudioMapPageState();
}

class _DanceStudioMapPageState extends State<DanceStudioMapPage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _setMarkers();
  }

  void _setMarkers() {
    final state = context.read<DanceStudioBloc>().state;
    if (state is DanceStudioLoaded) {
      setState(() {
        _markers.clear();
        for (var studio in state.studios) {
          _markers.add(
            Marker(
              markerId: MarkerId(studio.name),
              position: LatLng(studio.latitude, studio.longitude),
              infoWindow: InfoWindow(
                title: studio.name,
                snippet: studio.address,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: studio,
                  );
                },
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceStudioBloc, DanceStudioState>(
      builder: (context, state) {
        Set<Marker> markers = {};

        if (state is DanceStudioLoaded) {
          markers = state.studios.map((studio) {
            return Marker(
              markerId: MarkerId(studio.name),
              position: LatLng(studio.latitude, studio.longitude),
              infoWindow: InfoWindow(
                title: studio.name,
                snippet: studio.address,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: studio,
                  );
                },
              ),
            );
          }).toSet();
        }

        return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(52.2297, 21.0122),
            zoom: 6,
          ),
          markers: markers,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        );
      },
    );
  }
}

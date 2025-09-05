import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../common/services/location_service.dart';

class RiderMapScreen extends StatefulWidget {
  const RiderMapScreen({super.key});

  @override
  State<RiderMapScreen> createState() => _RiderMapScreenState();
}

class _RiderMapScreenState extends State<RiderMapScreen> {
  GoogleMapController? _controller;
  LatLng _center = const LatLng(37.42796133580664, -122.085749655962);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final bool ok = await LocationService.instance.ensurePermissions();
    if (!ok) return;
    final position = await LocationService.instance.currentPosition();
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rider Live Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 14),
        onMapCreated: (GoogleMapController c) => _controller = c,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}


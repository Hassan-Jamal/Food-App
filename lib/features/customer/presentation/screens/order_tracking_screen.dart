import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final List<String> _steps = <String>['Placed', 'Accepted', 'Preparing', 'On the Way', 'Delivered'];
  int _current = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 13),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),
          Expanded(
            child: Stepper(
              currentStep: _current,
              controlsBuilder: (BuildContext context, ControlsDetails details) => const SizedBox.shrink(),
              steps: _steps
                  .map(
                    (String s) => Step(
                      title: Text(s),
                      content: const SizedBox.shrink(),
                      isActive: _steps.indexOf(s) <= _current,
                      state: _steps.indexOf(s) < _current ? StepState.complete : StepState.indexed,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}


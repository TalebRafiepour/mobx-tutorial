import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _initialPosition =
      const CameraPosition(target: LatLng(35.716805, 51.390323), zoom: 12);

  Marker? _marker;
  String? _markerAddress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialPosition,
              myLocationEnabled: true,
              onTap: _onMapTap,
              markers: _marker == null ? {} : {_marker!},
            ),
            if (_markerAddress != null)
              Container(
                height: 64,
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(child: Text(_markerAddress ?? '')),
              )
          ],
        ),
      ),
    );
  }

  void _onMapTap(LatLng latLng) async {
    setState(() {
      _marker = Marker(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (_) => SelectedLocationPopUp(
                    latLng: latLng,
                    onSendLocation: () {
                      setState(() {
                        _marker = null;
                        _markerAddress = null;
                      });
                    },
                  ));
        },
        markerId: const MarkerId('0'),
        position: latLng,
      );
    });
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    setState(() {
      _markerAddress =
          '${placeMarks[0].street} ${placeMarks[0].locality} ${placeMarks[0].subLocality} ${placeMarks[0].isoCountryCode} ${placeMarks[0].postalCode}';
    });
    print('tapped location: ${latLng.toJson().toString()}');
  }
}

class SelectedLocationPopUp extends StatelessWidget {
  final LatLng latLng;
  final VoidCallback? onSendLocation;

  const SelectedLocationPopUp(
      {Key? key, required this.latLng, this.onSendLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Selected Location',
            style: TextStyle(fontSize: 24),
          ),
          const Spacer(flex: 4),
          Text('Selected Location LatLng: ${latLng.toString()}'),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onSendLocation?.call();
              },
              child: const Text('Send This Location'))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/presentation/widgets/app_input_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FasilitasPage extends StatefulWidget {
  FasilitasPage({Key? key}) : super(key: key);

  @override
  State<FasilitasPage> createState() => _FasilitasPageState();
}

class _FasilitasPageState extends State<FasilitasPage> {
  late GoogleMapController mapController;

  LatLng _center = LatLng(-7.7498444, 110.4049287);

  @override
  void initState() {
    requestLocationPermission();
    getCurrentPosition();
    super.initState();
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (!(permission == LocationPermission.denied) ||
        !(permission == LocationPermission.deniedForever)) {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _center = LatLng(pos.latitude, pos.longitude);
    }

    print(_center);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location not enabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied)
        return Future.error('location denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry borderRadius = BorderRadius.only(
        topLeft: Radius.circular(25), topRight: Radius.circular(25));
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: borderRadius,
        maxHeight: 150,
        minHeight: 150,
        panel: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  SizedBox(width: 8),
                  Text('Fasilitas', style: NendaStyles.fontMedium),
                ],
              ),
              AppInput(
                hintText: 'Cont. Kamar Mandi, WC, Pemandian Air Panas',
              )
            ],
          ),
        ),
        body: _bodyContent(),
      ),
    );
  }

  Widget _bodyContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15,
        ),
      ),
    );
  }
}

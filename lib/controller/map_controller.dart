import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  GoogleMapController? googleMapController;

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    update();
  }

  void moveCamera(CameraPosition position) {
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}

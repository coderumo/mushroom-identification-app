import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapController extends GetxController {
  GoogleMapController? googleMapController;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    update();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Hata', 'Konum servisleri açık değil.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Hata', 'Konum izni reddedildi.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Hata', 'Konum izni kalıcı olarak reddedildi.');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng latLng = LatLng(position.latitude, position.longitude);
      googleMapController?.animateCamera(CameraUpdate.newLatLng(latLng));
      selectedLocation.value = latLng;
      update();
    } catch (e) {
      printError(e);
    }
  }

  void printError(dynamic error) {
    print("Error: $error");
  }
}

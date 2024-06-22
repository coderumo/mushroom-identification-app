import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {
  GoogleMapController? googleMapController;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  RxString address = ''.obs;
  final List<LatLng> mushroomLocations = [
    const LatLng(37.7749, -122.4194),
    const LatLng(34.0522, -118.2437),
    const LatLng(40.7128, -74.0060),
  ];

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
      await getAddressFromLatLng(latLng);
      update();
    } catch (e) {
      printError(e);
    }
  }

  Future<void> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        address.value =
            '${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
      } else {
        address.value = 'Adres bulunamadı';
      }
    } catch (e) {
      printError(e);
    }
  }

  void printError(dynamic error) {
    print("Error: $error");
  }
}

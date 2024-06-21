import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controller/map_controller.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());
    const String title = 'Mantar Noktaları';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: mapController.getCurrentLocation,
          ),
        ],
      ),
      body: GetBuilder<MapController>(
        builder: (controller) {
          return GoogleMap(
            onMapCreated: controller.onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 10,
            ),
            markers: {
              if (controller.selectedLocation.value != null)
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: controller.selectedLocation.value!,
                ),
              ...controller.mushroomLocations.map((location) => Marker(
                    markerId: MarkerId(location.toString()),
                    position: location,
                  )),
            },
            onTap: (LatLng latLng) async {
              controller.selectedLocation.value = latLng;
              await controller.getAddressFromLatLng(latLng);
              controller.update();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, mapController.selectedLocation.value);
        },
      ),
    );
  }
}

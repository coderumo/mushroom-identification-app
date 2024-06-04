import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tez_front/controller/map_controller.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haritada İşaretle ve Paylaş'),
      ),
      body: GetBuilder<MapController>(
        builder: (controller) {
          return GoogleMap(
            onMapCreated: controller.onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 10,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.moveCamera(const CameraPosition(
            target: LatLng(34.0522, -118.2457),
            zoom: 14,
          ));
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tez_front/controller/map_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              onMapCreated: mapController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapController.selectedLocation.value ??
                    const LatLng(37.7749, -122.4194),
                zoom: 10,
              ),
              markers: {
                if (mapController.selectedLocation.value != null)
                  Marker(
                    markerId: const MarkerId('selectedLocation'),
                    position: mapController.selectedLocation.value!,
                  ),
              },
              onTap: (LatLng latLng) async {
                mapController.selectedLocation.value = latLng;
                await mapController.getAddressFromLatLng(latLng);
              },
            );
          }),
          Positioned(
            bottom: 50,
            left: 10,
            child: Obx(() {
              return Column(
                children: [
                  Text('Adres: ${mapController.address.value}'),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: {
                        'city': mapController.address.value.split(',')[0],
                        'district': mapController.address.value.split(',')[1],
                        'latitude':
                            mapController.selectedLocation.value?.latitude ??
                                0.0,
                        'longitude':
                            mapController.selectedLocation.value?.longitude ??
                                0.0,
                      });
                    },
                    child: const Text('Konumu Onayla'),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: mapController.getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

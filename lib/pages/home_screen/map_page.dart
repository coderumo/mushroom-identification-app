import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/controller/map_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mantar Konum'),
        actions: [
          IconButton(
              onPressed: () {
                mapController.getCurrentLocation();
              },
              icon: const Icon(Icons.my_location))
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onMapCreated: mapController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapController.selectedLocation.value ??
                    const LatLng(41.36587581650286, 36.228993125259876),
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
            bottom: 30,
            left: 10,
            child: Obx(() {
              if (Database.instance.isGuest()) {
                return const SizedBox.shrink();
              } else {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        'Adres: ${mapController.address.value}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        List<String> addressParts =
                            mapController.address.value.split(', ');
                        String city =
                            addressParts.length > 1 ? addressParts[1] : '';
                        String district = addressParts[0];

                        Get.back(result: {
                          'city': city,
                          'district': district,
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
              }
            }),
          ),
        ],
      ),
    );
  }
}

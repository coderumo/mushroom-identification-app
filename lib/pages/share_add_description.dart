// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tez_front/pages/home_screen/map_page.dart';
// import 'package:tez_front/widgets/custom_button.dart';
// import '../../controller/map_controller.dart';

// class AddDescriptionPage extends StatefulWidget {
//   final File imageFile;

//   const AddDescriptionPage({required this.imageFile, Key? key})
//       : super(key: key);

//   @override
//   State<AddDescriptionPage> createState() => _AddDescriptionPageState();
// }

// class _AddDescriptionPageState extends State<AddDescriptionPage> {
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   LatLng? selectedLocation;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Paylaş'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Image.file(
//               widget.imageFile,
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Açıklama',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             GestureDetector(
//               onTap: () async {
//                 final result = await Get.to(() => const MapPage());
//                 if (result != null && result is LatLng) {
//                   selectedLocation = result;
//                   final mapController = Get.find<MapController>();
//                   locationController.text = mapController.address.value;
//                 }
//               },
//               child: AbsorbPointer(
//                 child: TextField(
//                   controller: locationController,
//                   decoration: const InputDecoration(
//                     labelText: 'Konum',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             CustomButton(
//               buttonText: 'Paylaş',
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

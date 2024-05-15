import 'package:get/get.dart';
import 'package:tez_front/models/mushroom_model.dart';
import 'package:tez_front/services/mushroom_service.dart';

class MushroomController extends GetxController {
  final MushroomService _service = MushroomService();
  var isLoading = true.obs;
  var mushrooms = <MushroomModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMushrooms();
  }

  void fetchMushrooms() async {
    try {
      isLoading(true);
      var mushroomList = await _service.fetchMushroom();
      if (mushroomList != null) {
        mushrooms.assignAll(mushroomList as Iterable<MushroomModel>);
      } else {}
    } finally {
      isLoading(false);
    }
  }
}

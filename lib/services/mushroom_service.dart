import 'dart:convert';

import 'package:tez_front/models/mushroom_model.dart';
import 'package:http/http.dart' as http;

class MushroomService {
  final String url = "https://jsonplaceholder.typicode.com/photos";

  Future<MushroomModel?> fetchMushroom() async {
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      print("istek başarılı");
      var jsonBody = MushroomModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("istek başarısız => ${res.statusCode}");
    }
    return null;
  }
}

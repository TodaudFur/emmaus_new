import 'dart:convert';
import 'dart:developer';

import 'package:emmaus_new/data/model/emmaus_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class EmmausController extends GetxController {
  final httpClient = http.Client();

  final _emmaus = EmmausModel(
      sundayTime: "sundayTime",
      wlbTime: "wlbTime",
      seniorPastor: "seniorPastor",
      pastor: "pastor",
      elder: "elder",
      leaders: []).obs;
  EmmausModel get emmaus => _emmaus.value;
  set emmaus(val) => _emmaus.value = val;

  getEmmaus() async {
    //엠마오 불러오기
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_get.php"),
      );
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        emmaus = EmmausModel.fromJson(jsonResponse['result']);
      } else {
        print('Error Select Emmaus');
      }
    } catch (_) {
      print("$_ (Select Emmaus)");
    }
  }
}

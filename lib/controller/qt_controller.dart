import 'dart:convert';

import 'package:emmaus_new/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class QTController extends GetxController {
  final httpClient = http.Client();

  @override
  void onInit() {
    super.onInit();
  }

  final _list = <String>[].obs;
  List<String> get list => _list;
  set list(val) => _list.value = val;

  final _isCheck = false.obs;
  get isCheck => _isCheck.value;
  set isCheck(val) => _isCheck.value = val;

  final userCR = Get.find<UserController>();

  getAllQt() async {
    var url = Uri.parse('$kBaseUrl/emmaus_qt_all_init.php');
    var result = await http.post(url, body: {"mb_id": userCR.userModel.id});

    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    list = body['date'];
  }
}

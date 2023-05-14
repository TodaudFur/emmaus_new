import 'package:emmaus_new/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'fre_controller.dart';

class FreRewardController extends GetxController {
  final httpClient = http.Client();
  final userCR = Get.find<UserController>();

  insertFreReward(String s) async {
    //프리퀀시 경품 입력
    var url = Uri.parse('$kBaseUrl/emmaus_frereward_process.php');
    var result = await http.post(url, body: {
      "mb_name": userCR.userModel.name,
      "reward": s,
    });
    print(result.body);
    final freController = Get.put(FreController());
    freController.deleteTicket();
  }
}

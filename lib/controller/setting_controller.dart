import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../data/model/question_model.dart';

class SettingController extends GetxController {
  final _questionList = <QuestionModel>[].obs;
  List<QuestionModel> get questionList => _questionList;
  set questionList(val) => _questionList.value = val;

  final _isQuestionLoading = false.obs;
  get isQuestionLoading => _isQuestionLoading.value;
  set isQuestionLoading(val) => _isQuestionLoading.value = val;

  final userCR = Get.find<UserController>();

  getQuestionList() async {
    isQuestionLoading = false;
    try {
      final response =
          await http.post(Uri.parse('$kBaseUrl/emmaus_get_qa.php'), body: {});
      print("Get Question Response : ${response.body}");
      if (response.statusCode == 200) {
        questionList = parseResponse(response.body);
        isQuestionLoading = true;
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  Future sendQuestion(String content) async {
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_question.php');
    var result = await http.post(url, body: {
      "content": content,
      "name": userCR.userModel.name,
    });
    return result.body;
  }

  static List<QuestionModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<QuestionModel>((json) => QuestionModel.fromJson(json))
        .toList();
  }

  final sendFCM = FirebaseFunctions.instance.httpsCallable('sendFCM');

  void sendFCMToMe(String content) async {
    try {
      final response =
          await http.post(Uri.parse('$kBaseUrl/emmaus_my_token.php'), body: {});
      print("Get My Token Response : ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        final HttpsCallableResult result = await sendFCM.call(
          <String, dynamic>{
            "token": body['token'],
            "title": "문의사항!",
            "body": "내용 : $content, 보낸사람 : ${userCR.userModel.name}"
          },
        );
        print(result.data);
      }
    } catch (e) {
      print("exception : $e");
    }
  }
//49a36886778d425d

  launchHomepage() async {
    const url = 'https://official-emmaus.com';
    await launchUrl(Uri.parse(url));
  }

  launchInstagram() async {
    const url = 'https://www.instagram.com/emmausworship';
    await launchUrl(Uri.parse(url));
  }
}

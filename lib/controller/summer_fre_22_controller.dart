import 'dart:convert';

import 'package:emmaus_new/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'fre_controller.dart';

class SummerFre22Controller extends GetxController {
  final httpClient = http.Client();

  @override
  void onInit() {
    getTryTime(dateKey: 'tryTimeDate22Summer', timeKey: 'tryTime22Summer');
    super.onInit();
  }

  final userCR = Get.find<UserController>();

  TextEditingController textController = TextEditingController();

  final _tryTime = 2.obs;
  int get tryTime => _tryTime.value;
  set tryTime(val) => _tryTime.value = val;

  final _question = ''.obs;
  get question => _question.value;
  set question(val) => _question.value = val;

  getQuestion() async {
    String date = DateFormat("MMdd").format(DateTime.now()).toString();
    print(date);
    var url = Uri.parse('$kBaseUrl/emmaus_fre_question.php');
    var result = await http.post(url, body: {
      "date": date,
    });
    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    question = body['question'];
  }

  getTryTime({required String dateKey, required String timeKey}) async {
    //프리퀀시 문제 정답 시도 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String toDayDate = DateFormat('MMdd').format(DateTime.now());
    String? lastVisitDate = prefs.getString(dateKey);

    if (toDayDate != lastVisitDate) {
      await prefs.setString(dateKey, toDayDate);
      tryTime = 2;
    } else {
      if (prefs.getInt(timeKey) != null) {
        if (tryTime != prefs.getInt(timeKey)) {
          tryTime = prefs.getInt(timeKey)!;
        }
      } else {
        tryTime == 2;
      }
    }
  }

  Future<bool> check(String answer) async {
    //프리퀀시 문제 정답 맞추기
    String date = DateFormat("MMdd").format(DateTime.now()).toString();
    var url = Uri.parse('$kBaseUrl/emmaus_answer_json.php');
    var result = await http.post(url, body: {"answer": answer, "date": date});

    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);

    if (body["result"] == "true") {
      if (userCR.userModel.special < 3) {
        userCR.iconsList[userCR.userModel.special] = kTrueSpecial;
        userCR.userModel.special++;
      }
      userCR.userUpdate();
      userCR.iconUpdate();
      insertFre();
      return true;
    } else {
      return false;
    }
  }

  checkAnswer(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.getString("lastVisitDate22Summer") ?? "";

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      check(s).then((value) async {
        if (value) {
          await prefs.setString('lastVisitDate22Summer', toDayDate);
          final freController = Get.find<FreController>();
          freController.increaseCount();
          Fluttertoast.showToast(
              msg: "정답입니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          if (tryTime == 0) {
            Fluttertoast.showToast(
                msg: "정답 입력 기회를 다 사용했습니다!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          } else {
            tryTime--;
            await prefs.setInt('tryTime22Summer', tryTime);
            Fluttertoast.showToast(
                msg: "오답입니다!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        }
      }).catchError((onError) {
        print("Error");
      });
    } else {
      Fluttertoast.showToast(
          msg: "오늘의 문제는 이미 풀었습니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  insertFre() async {
    //프리퀀시 개수 입력
    var url = Uri.parse('$kBaseUrl/emmaus_fre_process.php');
    var result = await http.post(url, body: {
      "mb_id": userCR.userModel.id,
      "special": userCR.userModel.special.toString(),
      "normal": (userCR.userModel.normal - 3).toString()
    });

    print(result.body);
  }
}

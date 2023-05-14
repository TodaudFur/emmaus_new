import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/worship_date.dart';

const baseUrl = 'https://official-emmaus.com/g5/bbs';

class FreController extends GetxController {
  final userCR = Get.find<UserController>();

  freInit() async {
    getWorshipDate();
    prefs = await SharedPreferences.getInstance();
    lastVisitDate = prefs.getString("lastDate22Summer") ?? "";

    int? summer = prefs.getInt("22SummerCount");

    if (summer != null) {
      setFre(summer);
    } else {
      getFreCount();
    }
    ticketCount = prefs.getInt("22SummerTicket") ?? 0;
  }

  setFre(int fre) async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/emmaus_summer_fre_set.php'), body: {
        "mb_name": userCR.userModel.name,
        "fre": fre.toString(),
      });
      print("Increase Ticket Response : ${response.body}");
      prefs.remove("22SummerCount");
      await getFreCount();
      isFreLoading = true;
    } catch (e) {
      print("exception : $e");
    }
  }

  late SharedPreferences prefs;
  String lastVisitDate = "";

  final _worshipDates = <WorshipDateModel>[].obs;
  List<WorshipDateModel> get worshipDates => _worshipDates;
  set worshipDates(val) => _worshipDates.value = val;

  final _checkCount = 0.obs;
  get checkCount => _checkCount.value;
  set checkCount(val) => _checkCount.value = val;

  final _ticketCount = 0.obs;
  get ticketCount => _ticketCount.value;
  set ticketCount(val) => _ticketCount.value = val;

  final confettiController =
      ConfettiController(duration: const Duration(seconds: 10));

  getWorshipDate() async {
    try {
      var map = <String, dynamic>{};
      final response =
          await http.post(Uri.parse('$baseUrl/emmaus_fre_date.php'), body: map);
      print("Get Worship Date Response : ${response.body}");
      if (response.statusCode == 200) {
        worshipDates = parseResponse(response.body);
      }
    } catch (e) {
      print("exception : $e");
      worshipDates = <WorshipDateModel>[];
    }
  }

  static List<WorshipDateModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<WorshipDateModel>((json) => WorshipDateModel.fromJson(json))
        .toList();
  }

  final _tokenList = <dynamic>[].obs;
  List<dynamic> get tokenList => _tokenList;
  set tokenList(val) => _tokenList.value = val;

  getFirebaseToken() async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/emmaus_firebase_token_select.php'),
          body: {});
      print("Get Firebase Token Response : ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        tokenList = body['token'];
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  increaseCount() async {
    print(checkCount);
    if (checkCount < 17) {
      checkCount++;
      //await prefs.setInt("22SummerCount", checkCount);
      increaseTicketServer();
      if (checkCount == 17) {
        increaseTicket();
        confettiController.play();
        Future.delayed(const Duration(seconds: 30), () {
          confettiController.stop();
        });
      }
    }
  }

  increaseTicketServer() async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/emmaus_summer_fre.php'), body: {
        "mb_name": userCR.userModel.name,
      });
      print("Increase Ticket Response : ${response.body}");
    } catch (e) {
      print("exception : $e");
      Get.defaultDialog(title: "실패", content: const Text("다시 시도해주세요"));
    }
  }

  updateEgg() async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/emmaus_summer_egg_count.php'), body: {
        "mb_name": userCR.userModel.name,
      });
      print("Update Egg Response : ${response.body}");
    } catch (e) {
      print("exception : $e");
    }
  }

  increaseTicket() async {
    ticketCount++;
    await prefs.setInt("22SummerTicket", checkCount);
  }

  deleteTicket() async {
    ticketCount--;
    prefs.remove("22SummerTicket");
  }

  worshipCheck() async {
    if (int.parse(DateFormat("yyyyMMdd").format(DateTime.now())) > 20220630) {
      Fluttertoast.showToast(
          msg: "22 썸머 E-프리퀀시 기간이 끝났습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (lastVisitDate != DateFormat("yyyyMMdd").format(DateTime.now())) {
        print("lastVisitDate : $lastVisitDate");
        print(DateFormat("yyyyMMdd").format(DateTime.now()));
        if (worshipDates
            .where((element) =>
                element.date == DateFormat("yyyyMMdd").format(DateTime.now()) &&
                element.startTime <=
                    int.parse(DateFormat("HHmm").format(DateTime.now())) &&
                element.endTime >=
                    int.parse(DateFormat("HHmm").format(DateTime.now())))
            .isNotEmpty) {
          print(int.parse(DateFormat("HHmm").format(DateTime.now())));
          await prefs.setString(
              'mDateKeyWinter', DateFormat("yyyyMMdd").format(DateTime.now()));

          lastVisitDate = DateFormat("yyyyMMdd").format(DateTime.now());
          prefs.setString("lastDate22Summer", lastVisitDate);
          increaseCount();
          Fluttertoast.showToast(
              msg: "E-프리퀀시 체크 성공!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          print(int.parse(DateFormat("HHmm").format(DateTime.now())));

          Fluttertoast.showToast(
              msg: "예배 출석 시간이 아닙니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "오늘은 이미 출석하셨습니다!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }

  final _eggCount = 0.obs;
  get eggCount => _eggCount.value;
  set eggCount(val) => _eggCount.value = val;

  getFreCount() async {
    isFreLoading = false;
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/emmaus_summer_get_fre.php'), body: {
        "mb_name": userCR.userModel.name,
      });
      print("Get Fre Count Response : ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        checkCount = int.parse(body['fre']);
        isFreLoading = true;
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  getEggCount() async {
    isEggLoading = false;
    eggCount = 0;
    int? egg = prefs.getInt("eggCount");
    print("egg : $egg");
    if (egg != null) {
      eggCount = egg;
    }
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/emmaus_summer_egg_count_get.php'), body: {
        "mb_name": userCR.userModel.name,
      });
      print("Get Egg Response : ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        eggCount += int.parse(body['egg']);
        if (egg != null) {
          setEgg(eggCount);
        }
        isEggLoading = true;
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  setEgg(int egg) async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/emmaus_summer_egg_set.php'), body: {
        "mb_name": userCR.userModel.name,
        "egg": egg.toString(),
      });
      print("Set Egg Response : ${response.body}");
      prefs.remove("eggCount");
    } catch (e) {
      print("exception : $e");
    }
  }

  final _isFreLoading = false.obs;
  get isFreLoading => _isFreLoading.value;
  set isFreLoading(val) => _isFreLoading.value = val;

  final _isEggLoading = false.obs;
  get isEggLoading => _isEggLoading.value;
  set isEggLoading(val) => _isEggLoading.value = val;
}

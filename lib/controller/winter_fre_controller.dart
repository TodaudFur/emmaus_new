import 'dart:convert';

import 'package:emmaus_new/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class WinterFreController extends GetxController {
  final httpClient = http.Client();

  @override
  void onInit() {
    getQuestion();
    getQTCount();
    getWinter();
    getTryTime();
    super.onInit();
  }

  final userCR = Get.find<UserController>();

  TextEditingController textController = TextEditingController();

  final _tryTime = 2.obs;
  int get tryTime => _tryTime.value;
  set tryTime(val) => _tryTime.value = val;

  final _progressValue = 0.0.obs;
  double get progressValue => _progressValue.value;
  set progressValue(val) => _progressValue.value = val;

  final _progressColor = Colors.red[300].obs;
  Color? get progressColor => _progressColor.value;
  set progressColor(val) => _progressColor.value = val;

  final _question = ''.obs;
  get question => _question.value;
  set question(val) => _question.value = val;

  final _special = 0.obs;
  int get special => _special.value;
  set special(val) => _special.value = val;

  final _normal = 0.obs;
  int get normal => _normal.value;
  set normal(val) => _normal.value = val;

  final _isReward = false.obs;
  bool get isReward => _isReward.value;
  set isReward(val) => _isReward.value = val;

  void setNormal() {
    //프리퀀시 예배 출석시 처리
    if (userCR.userModel.normal < 9) {
      userCR.iconsList[userCR.userModel.normal] = kTrueNormal;
      userCR.userModel.normal++;
    }
    userCR.userUpdate();
    userCR.iconUpdate();
    Fluttertoast.showToast(
        msg: "예배 출석 완료!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  getWinter() async {
    //프리퀀시 개수 불러오기
    var url = Uri.parse('$kBaseUrl/emmaus_winter_fre_init.php');
    var result = await http.post(url, body: {
      "mb_id": userCR.userModel.id,
    });

    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);

    userCR.userModel.special = int.parse(body['special']);
    userCR.userModel.normal = int.parse(body['normal']) + 3;

    userCR.userUpdate();

    for (int i = 0; i < 3; i++) {
      if (i < userCR.userModel.special) {
        userCR.iconsList[i] = kTrueSpecial;
      } else {
        userCR.iconsList[i] = kFalseSpecial;
      }
    }
    for (int i = 3; i < 9; i++) {
      if (i < userCR.userModel.normal) {
        userCR.iconsList[i] = kTrueNormal;
      } else {
        userCR.iconsList[i] = kFalseNormal;
      }
    }
    userCR.iconUpdate();
  }

  getTryTime() async {
    //프리퀀시 문제 정답 시도 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String toDayDate = DateFormat('MMdd').format(DateTime.now());
    String? lastVisitDate = prefs.getString("tryTimeDateWinter");

    if (toDayDate != lastVisitDate) {
      await prefs.setString('tryTimeDateWinter', toDayDate);
      tryTime = 2;
    } else {
      if (prefs.getInt("tryTimeWinter") != null) {
        if (tryTime != prefs.getInt("tryTimeWinter")) {
          tryTime = prefs.getInt("tryTimeWinter")!;
        }
      } else {
        tryTime = 2;
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

  checkAnswer(String s, context) async {
    //프리퀀시 문제 정답 맞추기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastVisitDate = prefs.getString("specialDateKeyWinter");
    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      check(s).then((value) async {
        Navigator.pop(context);
        if (value) {
          await prefs.setString('specialDateKeyWinter', toDayDate);
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
            await prefs.setInt('tryTime', tryTime);
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
          msg: "오늘의 미션은 이미 출석되었습니다!",
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

  worshipCheck() async {
    //프리퀀시 예배 출석
    String nowDay = DateFormat('EEEE').format(DateTime.now());
    int nowTime = int.parse(DateFormat('HHmm').format(DateTime.now()));

    bool check = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastVisitDate = prefs.getString("mDateKeyWinter");

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    int endDate = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

    if (endDate > 20211225) {
      Fluttertoast.showToast(
          msg: "21 윈터 e-프리퀀시 기간이 끝났습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (userCR.userModel.userId != 0) {
        if (userCR.userModel.normal == 6) {
          Fluttertoast.showToast(
              msg: "예배 출석을 모두 성공하셨습니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          if (lastVisitDate != toDayDate) {
            if (nowDay == "Sunday") {
              if (nowTime <= 1700 && nowTime >= 1400) {
                check = true;
                setNormal();
                insertFre();
              }
              if (check) await prefs.setString('mDateKeyWinter', toDayDate);
            } else if (nowDay == "Friday" && toDayDate != "1224") {
              if (nowTime <= 2359 && nowTime >= 2100) {
                check = true;
                setNormal();
                insertFre();
              }
              if (check) await prefs.setString('mDateKeyWinter', toDayDate);
            } else if (nowDay == "Saturday" && toDayDate == "1225") {
              if (nowTime <= 1300 && nowTime >= 0700) {
                check = true;
                setNormal();
                insertFre();
              }
              if (check) await prefs.setString('mDateKeyWinter', toDayDate);
            } else {
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
      } else {
        Fluttertoast.showToast(
            msg: "로그인 후 이용 가능합니다!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }

  missionCheck(context) {
    //프리퀀시 미션 문제 팝업
    int endDate = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    print(endDate);

    if (endDate > 20211225) {
      Fluttertoast.showToast(
          msg: "22 윈터 e-프리퀀시 기간이 끝났습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (userCR.userModel.userId != 0) {
        if (userCR.userModel.special == 3) {
          Fluttertoast.showToast(
              msg: "미션을 모두 성공하셨습니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: AlertDialog(
                        title: const Text(
                          "스페셜미션",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Noto',
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                '문제 : $question',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Text(
                                '(입력 기회 : $tryTime/2)',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              const Divider(),
                              TextField(
                                  onSubmitted: (String s) {
                                    setState(() {
                                      checkAnswer(s, context);
                                      textController.text = "";
                                    });
                                  },
                                  controller: textController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '정답',
                                  )),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('확인'),
                                onPressed: () {
                                  setState(() {
                                    checkAnswer(textController.text, context);
                                    textController.text = "";
                                  });
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('취소'),
                                onPressed: () {
                                  textController.text = "";
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }));
        }
      } else {
        Fluttertoast.showToast(
            msg: "로그인 후 이용 가능합니다!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }

  getQTCount() async {
    //qt 개수 불러오기
    var url = Uri.parse('$kBaseUrl/emmaus_winter_qt.php');
    var result = await http.post(url, body: {
      "mb_id": userCR.userModel.id,
    });
    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    int count = int.parse(body['count'].toString());
    progressValue = (count / 24);

    if (progressValue < 0.4) {
      progressColor = Colors.red[300];
    } else if (progressValue < 0.7) {
      progressColor = Colors.orange[300];
    } else {
      progressColor = Colors.green[300];
    }

    if (userCR.userModel.special == 3 &&
        userCR.userModel.normal == 6 &&
        (progressValue * 100) >= 70) {
      isReward = true;
    }
  }

  getQuestion() async {
    //프리퀀시 문제 불러오기
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../controller/fre_controller.dart';
import '../../ui/summer_fre/views/egg.dart';
import '../../ui/summer_fre/widgets/answer_dialog.dart';
import '../../ui/summer_fre/widgets/check_chart.dart';
import '../../ui/summer_fre/widgets/qrscanner.dart';
import 'views/summer_reward.dart';
import 'widgets/draw_widget.dart';

class SummerFre extends StatelessWidget {
  SummerFre({Key? key}) : super(key: key);

  final freController = Get.put(FreController());
  @override
  Widget build(BuildContext context) {
    print(freController.checkCount);
    freController.freInit();
    if (freController.checkCount == 17) {
      freController.confettiController.play();
      Future.delayed(const Duration(seconds: 30), () {
        freController.confettiController.stop();
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kBodyColor,
          padding: const EdgeInsets.only(
              top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(CupertinoIcons.back)),
                    )),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset("asset/images/logo_ema.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor:
                                          kSelectColor.withOpacity(0.1),
                                    ),
                                    onPressed: () {
                                      freController.worshipCheck();
                                    },
                                    child: const FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        "예배 출석",
                                        style: TextStyle(
                                          fontFamily: 'Noto',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor:
                                          Colors.green.withOpacity(0.1),
                                    ),
                                    onPressed: () {
                                      int endDate = int.parse(
                                          DateFormat('yyyyMMdd')
                                              .format(DateTime.now()));
                                      print(endDate);

                                      if (endDate > 20220630) {
                                        Fluttertoast.showToast(
                                            msg: "22 썸머 e-프리퀀시 기간이 끝났습니다.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AnswerDialog());
                                      }
                                    },
                                    child: const FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        "문제 풀기",
                                        style: TextStyle(
                                          fontFamily: 'Noto',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor:
                                          Colors.yellow.withOpacity(0.1),
                                    ),
                                    onPressed: () {
                                      Get.to(const Egg());
                                    },
                                    child: const FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        "계란 깨기",
                                        style: TextStyle(
                                          fontFamily: 'Noto',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.1),
                                    ),
                                    onPressed: () async {
                                      if (DateTime.now()
                                          .isBefore(DateTime(2022, 7, 4))) {
                                        var result =
                                            await Get.to(const QRScanner());
                                        print("result : $result");
                                        if (result != null) {
                                          String r = result;
                                          print("split : ${r.split('/')[0]}");
                                          if (r.split('/')[0] == "EMMAUS") {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            if (prefs.getBool(r) == null ||
                                                prefs.getBool(r) == true) {
                                              if (prefs.getBool(r) == true) {
                                                prefs.setBool(r, false);
                                              }

                                              Get.defaultDialog(
                                                  title: "QR 코드 결과",
                                                  titleStyle: const TextStyle(
                                                    fontFamily: 'Noto',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                  content: const DrawWidget());
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "이미 사용한 QR 코드입니다.",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  fontSize: 16.0);
                                            }
                                          }
                                        }
                                      }
                                    },
                                    child: const FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        "QR 찍기",
                                        style: TextStyle(
                                          fontFamily: 'Noto',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      freController.ticketCount > 0
                          ? TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.blue.withOpacity(0.1),
                              ),
                              onPressed: () {
                                Get.to(const SummerReward());
                              },
                              child: const FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "경품 선택",
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Expanded(
                        flex: 7,
                        child: CheckChart(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

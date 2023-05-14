import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/fre_controller.dart';

class DrawWidget extends StatefulWidget {
  const DrawWidget({Key? key}) : super(key: key);

  @override
  State<DrawWidget> createState() => _DrawWidgetState();
}

class _DrawWidgetState extends State<DrawWidget> {
  int rndNumber = Random().nextInt(100);
  Widget drawContent = const SpinKitHourGlass(
    color: kSelectColor,
    duration: Duration(seconds: 2),
  );

  final freController = Get.find<FreController>();
  final userCR = Get.find<UserController>();

  final sendFCM = FirebaseFunctions.instance.httpsCallable('sendFCM');

  void sendFCMAllDevice() async {
    await freController.getFirebaseToken();
    print(freController.tokenList);
    if (freController.tokenList.isEmpty) return;
    final HttpsCallableResult result = await sendFCM.call(
      <String, dynamic>{
        "token": freController.tokenList,
        "title": "WOW",
        "body": "${userCR.userModel.name}님이 잭팟에 당첨됐습니다!!"
      },
    );
    print(result.data);
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        if (rndNumber < 10) {
          drawContent = const Text(
            "E-프리퀀시 체크 성공!!",
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.w900,
            ),
          );
          freController.increaseCount();
        } else if (rndNumber < 1) {
          drawContent = const Text(
            "잭팟!!!!\n응모권 1개 획득!",
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.w900,
            ),
          );
          freController.increaseTicket();
          sendFCMAllDevice();
        } else {
          drawContent = const Text(
            "꽝!",
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.w900,
            ),
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return drawContent;
  }
}

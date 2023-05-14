import 'package:emmaus_new/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_reward.dart';

class CheckESuccess extends StatelessWidget {
  CheckESuccess({Key? key}) : super(key: key);

  final userCR = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    if (userCR.userModel.special == 3 && userCR.userModel.normal == 9) {
      return const FittedBox(
        fit: BoxFit.fitHeight,
        child: ChooseReward(),
      );
    } else {
      return Column(
        children: const [
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                "SHOW\nYOUR WORSHIP!",
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                "6/13 ~ 7/9",
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }
    ;
  }
}

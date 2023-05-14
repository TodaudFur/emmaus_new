import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/controller/winter_fre_controller.dart';
import 'package:emmaus_new/ui/widgets/progress_widget.dart';
import 'package:emmaus_new/ui/widgets/qt_progress.dart';
import 'package:emmaus_new/winter_reward.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class Winter extends StatefulWidget {
  const Winter({super.key});

  @override
  State<Winter> createState() => _Winter();
}

class _Winter extends State<Winter> {
  final wfCR = Get.put(WinterFreController());

  final userCR = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 7.0, bottom: 12.0, left: 9.0, right: 9.0),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.asset("asset/images/logo_ema.png"),
                  ),
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
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Obx(
                            () => wfCR.isReward
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kSelectColor),
                                    onPressed: () {
                                      Get.to(const WinterReward());
                                    },
                                    child: const Text("경품선택"))
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Center(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            onPressed:
                                                wfCR.missionCheck(context),
                                            child: const FittedBox(
                                              fit: BoxFit.fitHeight,
                                              child: Text(
                                                "스페셜미션",
                                                style: TextStyle(
                                                  fontFamily: 'Noto',
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Center(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            onPressed: wfCR.worshipCheck(),
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
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: 300,
                        height: 20,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: ProgressWidget(
                            progressValue: wfCR.progressValue,
                            progressColor: wfCR.progressColor!,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: QTProgress(
                          progress: (wfCR.progressValue * 100).toInt(),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: userCR.iconsList[0],
                                          ))),
                                  Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: userCR.iconsList[1],
                                          ))),
                                  Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: userCR.iconsList[2],
                                          ))),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: userCR.iconsList[3],
                                        )),
                                  ),
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: userCR.iconsList[4],
                                          ))),
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: userCR.iconsList[5],
                                          ))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: userCR.iconsList[6],
                                          ))),
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: userCR.iconsList[7],
                                          ))),
                                  Expanded(
                                      child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: userCR.iconsList[8],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
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

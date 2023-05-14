import 'package:emmaus_new/controller/emmaus_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

///예배 시간, 회장단, 팀장 명단 등 엠마오 기본 정보 페이지

class Emmaus extends StatefulWidget {
  const Emmaus({Key? key}) : super(key: key);

  @override
  State<Emmaus> createState() => _EmmausState();
}

class _EmmausState extends State<Emmaus> {
  final emmausCR = Get.put(EmmausController());

  @override
  void initState() {
    emmausCR.getEmmaus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.arrow_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            const Divider(
              color: kBodyColor,
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: kBodyColor,
                padding: const EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 100.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "asset/images/logo_ema.png",
                          width: 120,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const Text(
                        '예배 안내',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Noto',
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const Text(
                        '주일 예배',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Noto',
                          fontSize: 16,
                        ),
                      ),
                      Obx(
                        () => Text(
                          emmausCR.emmaus.sundayTime,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Noto',
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '워라밸 금요성령대망회',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Noto',
                          fontSize: 16,
                        ),
                      ),
                      Obx(
                        () => Text(
                          emmausCR.emmaus.wlbTime,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Noto',
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const Text(
                        '섬기는 사람들',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Noto',
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          const Text(
                            '담임목사',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Noto',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Obx(
                            () => Text(
                              emmausCR.emmaus.seniorPastor,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Noto',
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '교역자',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Noto',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Obx(
                            () => Text(
                              emmausCR.emmaus.pastor,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Noto',
                                color: Colors.grey[700],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            '부장장로',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Noto',
                              fontSize: 12,
                            ),
                          ),
                          Obx(
                            () => Text(
                              emmausCR.emmaus.elder,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Noto',
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Obx(
                          () => Wrap(
                            children: List.generate(
                              emmausCR.emmaus.leaders.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      emmausCR.emmaus.leaders[index].type,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Noto',
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      emmausCR.emmaus.leaders[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Noto',
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
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
          ],
        ),
      ),
    );
  }
}

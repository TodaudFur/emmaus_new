import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/fre_reward_controller.dart';

class SummerReward extends StatefulWidget {
  const SummerReward({Key? key}) : super(key: key);

  @override
  State<SummerReward> createState() => _SummerRewardState();
}

class _SummerRewardState extends State<SummerReward> {
  String reward = "";
  String size = "";

  final rewardCR = Get.put(FreRewardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
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
            ),
            const Divider(
              color: kBodyColor,
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: kBodyColor,
                padding: const EdgeInsets.only(
                    top: 70.0, left: 30.0, right: 30.0, bottom: 100.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10.0, right: 20.0),
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
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 3, child: Container()),
                            const Expanded(
                              flex: 6,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'E-프리퀀시 경품 선택',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Noto',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(flex: 3, child: Container()),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: "티셔츠",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              const Text(
                                '티셔츠',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "볼캡",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              const Text(
                                '볼캡',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "벽걸이 시계",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              const Text(
                                '벽걸이 시계',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: "담요",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              const Text(
                                '담요',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "슬리퍼",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              const Text(
                                '슬리퍼',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "에어팟 응모권",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              const Text(
                                '에어팟 응모권',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: detail(),
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

  Widget detail() {
    switch (reward) {
      case "볼캡":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              children: [
                const Text(
                  '볼캡 사이즈는 Free로 제공됩니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Noto',
                  ),
                ),
                const Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    rewardCR.insertFreReward("볼캡");

                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: const Text(
                    "선택하기",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case "벽걸이 시계":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '벽걸이 시계가 제공됩니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ),
                const Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    rewardCR.insertFreReward("벽걸이 시계");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: const Text(
                    "선택하기",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case "티셔츠":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Column(
            children: [
              Text(
                '티셔츠 $size사이즈로 제공됩니다.',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Noto',
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: "S",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'S',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "M",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'M',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "L",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'L',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "XL",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'XL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "XXL",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  const Text(
                    'XXL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30.0,
                color: Colors.white,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  rewardCR.insertFreReward("티셔츠 : $size");
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "경품이 선택되었습니다!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                },
                child: const Text(
                  "선택하기",
                  style: TextStyle(
                    fontFamily: 'Noto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
      case "담요":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '담요가 제공됩니다',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ),
                const Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    rewardCR.insertFreReward("담요");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: const Text(
                    "선택하기",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case "슬리퍼":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '슬리퍼가 제공됩니다',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ),
                const Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    rewardCR.insertFreReward("슬리퍼");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: const Text(
                    "선택하기",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case "에어팟 응모권":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '에어팟을 응모하시면\n추첨을 통해 에어팟이 지급됩니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    rewardCR.insertFreReward("에어팟 응모권");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: const Text(
                    "선택하기",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }
}

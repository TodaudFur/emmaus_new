import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/summer_fre_page.dart';
import 'package:emmaus_new/ui/question_list/question_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controller/setting_controller.dart';
import '../../emmaus.dart';
import '../../game.dart';
import '../../qtall.dart';
import '../../winter.dart';
import '../summer_fre/summer_fre.dart';

class SettingIcons extends StatelessWidget {
  SettingIcons({Key? key}) : super(key: key);

  final userCR = Get.find<UserController>();
  final settingCR = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Emmaus()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.person_2,
                        size: 40.0,
                      ),
                      Text(
                        '엠마오',
                        style: TextStyle(
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                        title: "e=프리퀀시",
                        content: Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kSelectColor,
                                ),
                                onPressed: () {
                                  Get.to(SummerFrePage());
                                },
                                child: const Text("2021 하계")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kSelectColor,
                                ),
                                onPressed: () {
                                  if (userCR.userModel.userId != 0) {
                                    Get.to(const Winter());
                                  } else {
                                    Get.snackbar("Error", "로그인 후 이용해주세요");
                                  }
                                },
                                child: const Text("2021 동계")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kSelectColor,
                                ),
                                onPressed: () {
                                  if (userCR.userModel.userId != 0) {
                                    if (DateTime.now()
                                        .isAfter(DateTime(2022, 6, 1))) {
                                      Get.to(SummerFre());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "기간이 아닙니다.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "로그인 후 이용해주세요.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  }
                                },
                                child: const Text("2022 하계")),
                          ],
                        ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.flame,
                        size: 40.0,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'e-프리퀀시',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: settingCR.launchInstagram,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesomeIcons.instagram,
                        size: 40.0,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '인스타그램',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Game()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.gamecontroller,
                        size: 40.0,
                      ),
                      Text(
                        '게임',
                        style: TextStyle(
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: settingCR.launchHomepage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.home,
                      size: 40.0,
                    ),
                    Text(
                      '홈페이지',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              )),
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QtAll()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.checkmark_rectangle,
                      size: 40.0,
                    ),
                    Text(
                      '큐티 현황',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: Obx(() => userCR.userModel.userId == 5
                    ? TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Get.to(QuestionList());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              CupertinoIcons.speaker_3,
                              size: 40.0,
                            ),
                            Text(
                              '문의목록',
                              style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                        ),
                      )
                    : Container()),
              ),
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  TextEditingController controller = TextEditingController();
                  Get.defaultDialog(
                    title: "문의하기",
                    content: Column(
                      children: [
                        const Text(
                          "버그나 수정사항 또는 개선사항을 자유롭게 적어주세요",
                          style: TextStyle(
                            fontFamily: "Noto",
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kBodyColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: "여기에 입력해주세요"),
                              controller: controller,
                              maxLines: 8,
                            ),
                          ),
                        )
                      ],
                    ),
                    confirm: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSelectColor,
                        ),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            Get.dialog(const Center(
                              child: CircularProgressIndicator(),
                            ));
                            settingCR
                                .sendQuestion(controller.text)
                                .then((value) {
                              if (value == "true") {
                                final sc = Get.put(SettingController());
                                sc.sendFCMToMe(controller.text);
                                Get.back();
                                Get.back();
                                Get.snackbar("성공", "문의가 성공적으로 전송되었습니다");
                              }
                            });
                          }
                        },
                        child: const Text("전송")),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.speaker_3,
                      size: 40.0,
                    ),
                    Text(
                      '문의하기',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              )),
              Expanded(child: Container()),
            ],
          ),
        ),
        const Divider(
          color: kBodyColor,
          height: 40.0,
        ),
        const Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '그 날에 그들 중 둘이 예루살렘에서 이십오 리 되는\n엠마오라 하는 마을로 가면서\n이 모든 된 일을 서로 이야기하더라\n눅 24:13~14',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Noto',
                  color: Colors.grey),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }
}

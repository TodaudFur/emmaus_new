import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/view/bible_view.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/view/button_list.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/view/ox_view.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/view/typing_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final freCR = Get.find<Summer23FreController>();
  final userCR = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${userCR.userModel.name}님',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Noto',
                    color: Colors.black,
                  ),
                ),
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text: '현재 점수 : ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto',
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: freCR.score.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: freCR.tmpScore != 0 ? '+${freCR.tmpScore}' : '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Noto',
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: '점'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 1.5,
          margin: const EdgeInsets.only(top: 4),
          color: Colors.black.withOpacity(0.2),
        ),
        Obx(
          () => freCR.selectedType != ''
              ? InkWell(
                  onTap: () => freCR.selectBack(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kSelectColor,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          freCR.selectedType,
                          style: const TextStyle(
                            fontFamily: 'noto',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 20,
                ),
        ),
        Expanded(
          child: Obx(
            () => freCR.selectedType == ''
                ? ButtonList()
                : freCR.selectedType == '말씀 문제 풀기'
                    ? BibleView()
                    : freCR.selectedType == 'OX 문제 풀기'
                        ? OXView()
                        : const TypingView(),
          ),
        )
      ],
    );
  }
}

import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BibleView extends StatelessWidget {
  BibleView({Key? key}) : super(key: key);

  final freCR = Get.find<Summer23FreController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          freCR.bibleQuestion.question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Noto',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text(
              '정답 :  ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Noto',
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 30,
                child: TextField(
                  controller: freCR.bibleTC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kSelectColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kSelectColor),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto',
                  ),
                  cursorHeight: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () => freCR
                .bibleCheck(freCR.bibleQuestion.answer == freCR.bibleTC.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: kSelectColor,
            ),
            child: const Text(
              '제출',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Noto',
                fontWeight: FontWeight.bold,
              ),
            ))
      ],
    );
  }
}

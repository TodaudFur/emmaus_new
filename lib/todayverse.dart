import 'package:emmaus_new/controller/verse_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'constants.dart';

class TodayVerse extends StatelessWidget {
  TodayVerse({Key? key}) : super(key: key);
  final verseCR = Get.put(VerseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 8, child: Container()),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.square_arrow_down,
                      color: Colors.grey,
                    ),
                    onPressed: verseCR.takeScreenshot,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Screenshot(
              controller: verseCR.screenshotController,
              child: Container(
                color: kBodyColor,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            flex: 6,
                            child: Obx(
                              () => Text(
                                verseCR.todayVerse.korean,
                                style: const TextStyle(
                                  fontFamily: 'Mapo',
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Expanded(flex: 4, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 5,
                            child: Obx(
                              () => Text(
                                verseCR.todayVerse.english,
                                style: TextStyle(
                                  fontFamily: 'Mapo',
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

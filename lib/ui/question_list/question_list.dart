import 'package:emmaus_new/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/setting_controller.dart';

class QuestionList extends StatelessWidget {
  QuestionList({Key? key}) : super(key: key);

  final settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    settingController.getQuestionList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBodyColor,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: Obx(
          () => settingController.isQuestionLoading
              ? ListView.builder(
                  itemCount: settingController.questionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(settingController
                                    .questionList[index].content)),
                            Expanded(
                                child: Text(settingController
                                    .questionList[index].name)),
                            Expanded(
                                child: Text(DateFormat("yyyy-MM-dd").format(
                                    settingController
                                        .questionList[index].date))),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        )
                      ],
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}

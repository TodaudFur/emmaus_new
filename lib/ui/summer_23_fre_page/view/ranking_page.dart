import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/widgets/ranking_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankingPage extends StatelessWidget {
  RankingPage({Key? key}) : super(key: key);

  final freCR = Get.find<Summer23FreController>()..getRanking();
  final userCR = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: const Text(
          '랭킹',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Noto',
          ),
        ),
      ),
      backgroundColor: kBodyColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            child: Obx(
              () => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: kSelectColor.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${freCR.myRank}위',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Noto',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${userCR.userModel.name}님',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Noto',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Noto',
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: freCR.score.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const TextSpan(text: '점'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                          itemCount: freCR.rankList.length,
                          itemBuilder: (context, index) {
                            return RankingRow(rank: freCR.rankList[index]);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

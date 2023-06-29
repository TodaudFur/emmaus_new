import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/view/main_view.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/view/ranking_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Summer23FrePage extends StatelessWidget {
  Summer23FrePage({Key? key}) : super(key: key);

  final freCR = Get.put(Summer23FreController())..getScore();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
          title: const Text(
            '2023 여름 E-프리퀀시',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Noto',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Center(
                  child: InkWell(
                onTap: () => Get.to(RankingPage()),
                child: const Text(
                  '랭킹',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Noto',
                  ),
                ),
              )),
            ),
          ],
        ),
        backgroundColor: kBodyColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
              child: MainView(),
            ),
          ),
        ),
      ),
    );
  }
}

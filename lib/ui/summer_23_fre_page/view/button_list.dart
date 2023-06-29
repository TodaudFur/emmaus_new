import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonList extends StatelessWidget {
  ButtonList({Key? key}) : super(key: key);

  final freCR = Get.find<Summer23FreController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => freCR.enterBible(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF883939),
                    Color(0xFF502222),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('asset/images/bible.png')),
                      const Text(
                        "말씀 문제 풀기",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "입장 가능 ${freCR.bibleTicket ? "1" : "0"}/1",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: InkWell(
            onTap: () => freCR.enterOX(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E476D),
                    Color(0xFF1E2E47),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('asset/images/quiz.png')),
                      const Text(
                        "OX 문제 풀기",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "입장 가능 ${freCR.oxTicket ? "1" : "0"}/1",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: InkWell(
            onTap: () => freCR.selectType('말씀 타자 치기'),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF307232),
                    Color(0xFF1E471F),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('asset/images/typing.png')),
                      const Text(
                        "말씀 타자 치기",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "입장 가능 ∞",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

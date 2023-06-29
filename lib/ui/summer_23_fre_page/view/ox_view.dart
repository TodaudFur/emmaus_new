import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OXView extends StatelessWidget {
  OXView({Key? key}) : super(key: key);

  final freCR = Get.find<Summer23FreController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            '${freCR.oxStep + 1}/5',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Noto',
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              freCR.oxQuestion[freCR.oxStep].question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Noto',
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => freCR
                      .oxCheck(freCR.oxQuestion[freCR.oxStep].answer == "X"),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
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
                      child: const Text(
                        "X",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: InkWell(
                  onTap: () => freCR
                      .oxCheck(freCR.oxQuestion[freCR.oxStep].answer == "O"),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
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
                      child: const Text(
                        "O",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => freCR.oxIsCorrect == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: freCR.oxIsCorrect!
                      ? const Text(
                          '정답!',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        )
                      : const Text(
                          '오답!',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                ),
        ),
      ],
    );
  }
}

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/fre_controller.dart';

class CheckChart extends StatelessWidget {
  CheckChart({Key? key}) : super(key: key);

  final freController = Get.find<FreController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => freController.isFreLoading
            ? Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 0
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 1
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 2
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 3
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 4
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 5
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 6
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 7
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 16
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 8
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 9
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 10
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 11
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 12
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: freController.checkCount > 13
                                    ? kTrueNormal
                                    : kFalseNormal,
                              )),
                        ),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 14
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: freController.checkCount > 15
                                      ? kTrueNormal
                                      : kFalseNormal,
                                ))),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              )),
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: freController.confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.01,
            numberOfParticles: 1000,
            gravity: 0.09,
            shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
        ),
      ],
    );
  }
}

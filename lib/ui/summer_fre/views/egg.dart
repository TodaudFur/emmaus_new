import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/fre_controller.dart';

class Egg extends StatefulWidget {
  const Egg({Key? key}) : super(key: key);

  @override
  State<Egg> createState() => _EggState();
}

class _EggState extends State<Egg> {
  final freController = Get.find<FreController>();

  @override
  void initState() {
    freController.getEggCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBodyColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Obx(
            () => freController.isEggLoading
                ? Column(
                    children: [
                      Text(
                        "${freController.eggCount}/1530000",
                        style: const TextStyle(fontSize: 50),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            minHeight: 100,
                            value: freController.eggCount / 1530000,
                            color: const Color(0xFFffd79a),
                            backgroundColor: Colors.grey.shade300,
                            semanticsLabel: "${freController.eggCount}/1530000",
                            semanticsValue: "${freController.eggCount}/1530000",
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Expanded(
            child: FittedBox(
              child: IconButton(
                onPressed: () {
                  eggCounting();
                },
                splashColor: const Color(0xFFffd79a),
                iconSize: MediaQuery.of(context).size.width,
                icon: const Icon(
                  Icons.egg_outlined,
                  color: Color(0xFFffd79a),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  eggCounting() {
    setState(() {
      freController.eggCount += 3;
    });
    freController.updateEgg();
    if (freController.eggCount == 1530000 ||
        freController.eggCount == 300000 ||
        freController.eggCount == 600000 ||
        freController.eggCount == 900000 ||
        freController.eggCount == 120000) {
      if (DateTime.now().isBefore(DateTime(2022, 7, 4))) {
        freController.increaseCount();
        Fluttertoast.showToast(
            msg: "E-프리퀀시 체크 성공!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }
}

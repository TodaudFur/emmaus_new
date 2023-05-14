import 'package:emmaus_new/controller/qt_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants.dart';

///큐티 현황 페이지

class QtAll extends StatefulWidget {
  const QtAll({super.key});

  @override
  State<QtAll> createState() => _QtAllState();
}

class _QtAllState extends State<QtAll> {
  final qtCR = Get.put(QTController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const Divider(
              color: kBodyColor,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 3, child: Container()),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        DateTime.now().year.toString(),
                        style: const TextStyle(
                          fontFamily: 'Nanum',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 5, child: Container()),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xFFf0c653),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "${DateTime.now().month}월",
                            style: const TextStyle(
                              fontFamily: 'Nanum',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 5, child: Container()),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: GridView.builder(
                  itemCount: 31,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1, //item 의 가로
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.black.withOpacity(0.1)))),
                      child: Row(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                                backgroundColor: int.parse(
                                            qtCR.list[index].substring(6, 8)) ==
                                        index + 1
                                    ? const Color(0xFFf0c653)
                                    : kBodyColor,
                                child: Padding(
                                  padding: index < 9
                                      ? const EdgeInsets.all(4.7)
                                      : const EdgeInsets.all(2),
                                  child: FittedBox(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nanum',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child:
                                  int.parse(qtCR.list[index].substring(6, 8)) ==
                                          index + 1
                                      ? Image.asset("asset/images/book.png")
                                      : Image.asset("asset/images/empty.png"))
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(flex: 4, child: Container()),
          ],
        ),
      ),
    );
  }
}

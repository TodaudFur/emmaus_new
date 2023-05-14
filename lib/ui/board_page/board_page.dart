import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/board_controller.dart';
import 'package:emmaus_new/ui/board_page/widgets/board_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final boardCR = Get.find<BoardController>();

  @override
  void initState() {
    boardCR.getBoardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: kBodyColor,
          padding: const EdgeInsets.only(
              top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
          child: Obx(() => boardCR.boardList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kSelectColor,
                  ),
                )
              : ListView.builder(
                  itemCount: boardCR.boardList.length,
                  itemBuilder: (context, index) {
                    return BoardBox(board: boardCR.boardList[index]);
                  }))),
    );
  }
}

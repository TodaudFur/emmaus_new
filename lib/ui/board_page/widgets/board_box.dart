import 'package:emmaus_new/data/model/board_model.dart';
import 'package:emmaus_new/ui/board_page/views/post_list_page.dart';
import 'package:emmaus_new/ui/board_page/widgets/board_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardBox extends StatelessWidget {
  const BoardBox({Key? key, required this.board}) : super(key: key);

  final BoardModel board;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 200,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(PostListPage(
                tableType: board.tableType,
                tableName: board.tableName,
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  board.tableName,
                  style: const TextStyle(
                    fontFamily: 'Noto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: board.postList.isEmpty
                ? const Text(
                    "게시글이 없습니다",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: board.postList.length,
                    itemBuilder: (context, index) {
                      return BoardRow(
                        post: board.postList[index],
                        tableName: board.tableName,
                        tableType: board.tableType,
                      );
                    }),
          ),
        ],
      ),
    );
  }
}

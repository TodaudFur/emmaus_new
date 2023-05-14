import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/data/model/post_model.dart';
import 'package:emmaus_new/ui/board_page/views/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BoardRow extends StatelessWidget {
  const BoardRow({
    Key? key,
    required this.post,
    required this.tableName,
    required this.tableType,
  }) : super(key: key);

  final PostModel post;
  final String tableName;
  final String tableType;
  @override
  Widget build(BuildContext context) {
    final userCR = Get.find<UserController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        onTap: () {
          final userCR = Get.find<UserController>();
          if (post.isSecret) {
            if (post.userId == userCR.userModel.userId) {
              Get.to(PostDetailPage(
                post: post,
                tableName: tableName,
                tableType: tableType,
              ));
            } else {
              Get.snackbar("비밀글", "해당 비밀글에 대한 권한이 없습니다");
            }
          } else {
            Get.to(PostDetailPage(
              post: post,
              tableName: tableName,
              tableType: tableType,
            ));
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.black.withOpacity(0.1)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    tableName == "주보"
                        ? DateFormat("yyyy년 MM월 dd일 주보").format(post.date)
                        : userCR.userModel.userId == post.userId
                            ? post.title
                            : post.isSecret
                                ? "비밀글입니다"
                                : post.title,
                    style: const TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  userCR.userModel.userId == post.userId
                      ? Container()
                      : post.isSecret
                          ? const Icon(
                              Icons.lock,
                              size: 12,
                            )
                          : Container(),
                ],
              ),
              Text(
                DateFormat("yyyy-MM-dd").format(post.date),
                style: TextStyle(
                  fontFamily: 'Noto',
                  color: Colors.grey.withOpacity(0.8),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

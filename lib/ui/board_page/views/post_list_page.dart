import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/board_controller.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/login.dart';
import 'package:emmaus_new/ui/board_page/views/post_write_page.dart';
import 'package:emmaus_new/ui/board_page/widgets/board_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListPage extends StatefulWidget {
  const PostListPage(
      {Key? key, required this.tableType, required this.tableName})
      : super(key: key);

  final String tableType;
  final String tableName;
  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final boardCR = Get.find<BoardController>();
  final userCR = Get.find<UserController>();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    boardCR.getPostList(tableType: widget.tableType);
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch

    boardCR.getPostList(
        tableType: widget.tableType, startIndex: boardCR.postList.length);
    refreshController.loadComplete();
  }

  @override
  void initState() {
    boardCR.getPostList(tableType: widget.tableType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          widget.tableName,
          style: const TextStyle(
            fontFamily: 'Noto',
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              widget.tableName == "자유게시판" ||
                      (userCR.userModel.isLeader &&
                          (widget.tableName != '예배' &&
                              widget.tableName != '주보'))
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          String cell = '새가족';
                          if (userCR.userModel.cell == userCR.userModel.name) {
                            cell = userCR.userModel.cell;
                          }

                          if (userCR.userModel.userId != 0) {
                            if (widget.tableName == "셀기도게시판") {
                              if (cell != '') {
                                Get.to(PostWritePage(
                                  tableType: widget.tableType,
                                  cell: cell,
                                ));
                              } else {
                                Get.snackbar("실패", "셀리더가 아닙니다");
                              }
                            } else {
                              Get.to(PostWritePage(
                                tableType: widget.tableType,
                                cell: cell,
                              ));
                            }
                          } else {
                            Get.snackbar("로그인", "로그인이 필요합니다");
                            Get.off(const LoginPage());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kSelectColor,
                          ),
                          child: const Text(
                            "작성",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => boardCR.postGetLoading
                      ? boardCR.postList.isEmpty
                          ? const Center(
                              child: Text("게시물이 없습니다"),
                            )
                          : SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: CustomHeader(
                                builder: (BuildContext context,
                                    RefreshStatus? mode) {
                                  Widget body;
                                  if (mode == RefreshStatus.idle) {
                                    body = const Text("새로고침");
                                  } else if (mode == RefreshStatus.refreshing) {
                                    body = const CupertinoActivityIndicator();
                                  } else if (mode == RefreshStatus.failed) {
                                    body = const Text("실패");
                                  } else if (mode == RefreshStatus.canRefresh) {
                                    body = const Text("새로고침하기");
                                  } else {
                                    body = const Text("No more Data");
                                  }
                                  return SizedBox(
                                    height: 55.0,
                                    child: Center(child: body),
                                  );
                                },
                              ),
                              footer: CustomFooter(
                                builder:
                                    (BuildContext context, LoadStatus? mode) {
                                  Widget body;
                                  if (mode == LoadStatus.idle) {
                                    body = const Text("");
                                  } else if (mode == LoadStatus.loading) {
                                    body = const CupertinoActivityIndicator();
                                  } else if (mode == LoadStatus.failed) {
                                    body = const Text("실패");
                                  } else if (mode == LoadStatus.canLoading) {
                                    body = const Text("더보기");
                                  } else {
                                    body = const Text("");
                                  }
                                  return SizedBox(
                                    height: 55.0,
                                    child: Center(child: body),
                                  );
                                },
                              ),
                              controller: refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child: ListView.builder(
                                  itemCount: boardCR.postList.length,
                                  itemBuilder: (context, index) {
                                    return BoardRow(
                                      post: boardCR.postList[index],
                                      tableName: widget.tableName,
                                      tableType: widget.tableType,
                                    );
                                  }),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

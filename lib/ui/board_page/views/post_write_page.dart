import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/board_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({Key? key, required this.tableType, required this.cell})
      : super(key: key);

  final String tableType;
  final String cell;
  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  bool isSecret = false;
  bool isCellLoading = false;
  final boardCR = Get.find<BoardController>();

  final titleTC = TextEditingController();
  final contentTC = TextEditingController();

  @override
  void initState() {
    if (widget.tableType == 'pray') {
      boardCR.getCellPeople(cell: widget.cell).then((value) {
        if (value != null && value) {
          String cellPeople = "";
          for (int i = 0; i < boardCR.cellPeople.length; i++) {
            cellPeople += "${boardCR.cellPeople[i]} : \n";
          }
          contentTC.text = cellPeople;
          setState(() {
            isCellLoading = true;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          title: const Text(
            '글쓰기',
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.w900,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titleTC,
                          cursorColor: kSelectColor,
                          style:
                              const TextStyle(fontSize: 14, fontFamily: 'noto'),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                            labelText: '제목',
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       isSecret = !isSecret;
                      //     });
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isSecret,
                      //         activeColor: kSelectColor,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isSecret = value!;
                      //           });
                      //         },
                      //       ),
                      //       Text(
                      //         "비밀글",
                      //         style:
                      //             TextStyle(fontSize: 12, fontFamily: 'noto'),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  widget.tableType == 'pray' && !isCellLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextField(
                          controller: contentTC,
                          cursorColor: kSelectColor,
                          minLines: 15,
                          maxLines: 20,
                          style:
                              const TextStyle(fontSize: 14, fontFamily: 'noto'),
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 20),
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                            labelText: '내용',
                            labelStyle: const TextStyle(color: Colors.black),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      boardCR.postWrite(
                          title: titleTC.text,
                          content: contentTC.text,
                          isSecret: isSecret,
                          cell: widget.cell,
                          tableType: widget.tableType);
                    },
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kSelectColor,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "작성",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

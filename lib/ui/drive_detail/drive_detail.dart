import 'package:emmaus_new/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../../constants.dart';
import '../../controller/drive_controller.dart';

class DriveDetail extends StatefulWidget {
  const DriveDetail({Key? key}) : super(key: key);

  @override
  State<DriveDetail> createState() => _DriveDetailState();
}

class _DriveDetailState extends State<DriveDetail> {
  final driveController = Get.put(DriveController());
  final String title = Get.arguments ?? "";

  @override
  void initState() {
    driveController.getDriveList(title);
    driveController.addDirectory(title);
    driveController.directoryName = title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            if (title == '주일 예배' || title == '금요철야 예배') {
                              driveController.directoryList.clear();
                              Get.back();
                            } else {
                              if (driveController.directoryList.length <= 1) {
                                driveController.deleteDirectory();
                                Get.back();
                              } else {
                                driveController.deleteDirectory();
                              }
                            }
                          },
                          child: const Icon(CupertinoIcons.arrow_left)),
                      const SizedBox(
                        width: 15,
                      ),
                      Obx(
                        () => Text(
                          driveController.directoryName,
                          style: const TextStyle(
                            fontFamily: "Nanum",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.snackbar('404', 'Not Guhyun bballi halgyeyo');
                          },
                          icon: const Icon(CupertinoIcons.search)),
                      // PopupMenuButton(
                      //   padding: const EdgeInsets.all(1),
                      //   itemBuilder: (BuildContext context) => [
                      //     const PopupMenuItem(
                      //         height: 30,
                      //         child: Text(
                      //           "링크공유",
                      //           style: TextStyle(
                      //             fontSize: 10,
                      //             fontFamily: "Nanum",
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         )),
                      //     const PopupMenuItem(
                      //         height: 30,
                      //         child: Text(
                      //           "이름바꾸기",
                      //           style: TextStyle(
                      //             fontSize: 10,
                      //             fontFamily: "Nanum",
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         )),
                      //     const PopupMenuItem(
                      //         height: 30,
                      //         child: Text(
                      //           "삭제",
                      //           style: TextStyle(
                      //             fontSize: 10,
                      //             fontFamily: "Nanum",
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         )),
                      //   ],
                      //
                      // ),
                      InkWell(
                        onTap: () {
                          Get.snackbar('404', 'Not Guhyun bballi halgyeyo');
                        },
                        child: const Icon(
                          Icons.more_horiz,
                          size: 30,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 17.0, right: 17),
                  child: Obx(() => driveController.isLoading
                      ? driveController.driveList.isNotEmpty
                          ? ListView.builder(
                              itemCount: driveController.driveList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (driveController
                                            .driveList[index].fileType ==
                                        'folder') {
                                      driveController.addDirectory(
                                          driveController
                                              .driveList[index].fileName);
                                      driveController.directoryName =
                                          driveController
                                              .driveList[index].fileName;
                                      driveController.getDriveList(
                                          driveController
                                              .driveList[index].fileName);
                                    } else {
                                      final mimeType = lookupMimeType(
                                          ".${driveController.driveList[index].fileType}");
                                      final fileUrl =
                                          "$kBaseUrl/drive/${driveController.driveList[index].totalDirectory}${driveController.driveList[index].fileName}.${driveController.driveList[index].fileType}";
                                      switch (mimeType!.split("/").first) {
                                        case "image":
                                          Get.to(DetailScreen(
                                              item: [fileUrl], index: 0));
                                          break;
                                        default:
                                          driveController.downloadFile(fileUrl);
                                      }
                                    }
                                  },
                                  onLongPress: () {
                                    Get.defaultDialog(
                                      title: "파일 삭제",
                                      content: const Text("파일(폴더)를 삭제하시겠습니까?"),
                                      textConfirm: "삭제",
                                      onConfirm: () {
                                        driveController.removeFile(index);
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.only(
                                        top: 9, bottom: 9, left: 10),
                                    color: Colors.white,
                                    height: 30,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        FittedBox(
                                          child: driveController.getFileImage(
                                              driveController
                                                  .driveList[index].fileType),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            driveController
                                                .driveList[index].fileName,
                                            style: const TextStyle(
                                              fontFamily: "Nanum",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const Text("파일이 없습니다")
                      : const Center(
                          child: CircularProgressIndicator(
                            color: kSelectColor,
                          ),
                        )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: kSelectColor,
        overlayColor: Colors.black,
        overlayOpacity: 0.1,
        spacing: 10,
        spaceBetweenChildren: 5,
        activeChild: const Icon(CupertinoIcons.xmark),
        children: [
          SpeedDialChild(
              child: const Icon(CupertinoIcons.square_arrow_up),
              backgroundColor: const Color(0xFF1A4073),
              foregroundColor: Colors.white,
              label: '업로드',
              onTap: () {
                driveController.fileSave(driveController.directoryName);
              }),
          SpeedDialChild(
            child: const Icon(CupertinoIcons.folder_solid),
            backgroundColor: const Color(0xFF1A4073),
            foregroundColor: Colors.white,
            label: '폴더',
            onTap: () {
              driveController.folderSave(driveController.directoryName);
            },
          ),
        ],
        child: Center(
          child: Image.asset(
            "asset/images/logo_em_3.png",
            scale: 6.0,
          ),
        ),
      ),
    );
  }
}

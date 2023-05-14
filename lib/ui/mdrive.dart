import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/ui/drive_detail/drive_detail.dart';
import 'package:emmaus_new/ui/worship_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controller/drive_controller.dart';
import '../controller/drive_home_controller.dart';

class MDrive extends StatefulWidget {
  const MDrive({Key? key}) : super(key: key);

  @override
  State<MDrive> createState() => _MDriveState();
}

class _MDriveState extends State<MDrive> {
  final driveHomeController = Get.put(DriveHomeController());
  final userCR = Get.find<UserController>();

  @override
  void initState() {
    driveHomeController.getRecentFile();
    driveHomeController.getRecentFile7Days();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBodyColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "MDRIVE",
          style: TextStyle(
              fontFamily: "Nanum", fontWeight: FontWeight.w900, fontSize: 18),
        ),
        actions: const [
          // Padding(
          //   padding: const EdgeInsets.only(right: 17.0),
          //   child: InkWell(
          //     onTap: () {},
          //     child: const CircleAvatar(
          //       radius: 20,
          //       backgroundColor: Color(0xFF073355),
          //       child: Icon(
          //         CupertinoIcons.person_solid,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400]!.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 15,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              color: kBodyColor,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const WorshipDetail());
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 15,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: const Color(0xFF1A4073),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container()),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Image.asset(
                                                          "asset/images/folder.png",
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container()),
                                                    ],
                                                  )),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: Container()),
                                              const Expanded(
                                                  flex: 9,
                                                  child: Text(
                                                    "예배",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Nanum",
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  )),
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                  flex: 4,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Obx(() => FittedBox(
                                                          fit: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  500
                                                              ? BoxFit.none
                                                              : BoxFit
                                                                  .fitHeight,
                                                          child: Text(
                                                            driveHomeController
                                                                .getUpload(
                                                                    "worship"),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Nanum",
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width >
                                                                      500
                                                                  ? 12
                                                                  : null,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        )),
                                                  )),
                                              Expanded(
                                                  flex: 4, child: Container()),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const DriveDetail(),
                                        arguments: "광고");
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEBB144),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container()),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Image.asset(
                                                          "asset/images/folder.png",
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container()),
                                                    ],
                                                  )),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: Container()),
                                              const Expanded(
                                                  flex: 9,
                                                  child: Text(
                                                    "광고",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Nanum",
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  )),
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1, child: Container()),
                                              Expanded(
                                                  flex: 4,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Obx(() => FittedBox(
                                                          fit: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  500
                                                              ? BoxFit.none
                                                              : BoxFit
                                                                  .fitHeight,
                                                          child: Text(
                                                            driveHomeController
                                                                .getUpload(
                                                                    "ad"),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Nanum",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width >
                                                                      500
                                                                  ? 12
                                                                  : null,
                                                            ),
                                                          ),
                                                        )),
                                                  )),
                                              Expanded(
                                                  flex: 4, child: Container()),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                                width: Get.width,
                              ),
                              const Text(
                                "최근 7일이내 업로드 파일",
                                style: TextStyle(
                                    fontFamily: "Nanum",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: Obx(() => driveHomeController
                                          .recentFiles.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: driveHomeController
                                              .recentFiles.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                final driveController =
                                                    Get.put(DriveController());
                                                driveController.downloadFile(
                                                    "$kBaseUrl/drive/${driveHomeController.recentFiles[index].totalDirectory}/${driveHomeController.recentFiles[index].fileName}.${driveHomeController.recentFiles[index].fileType}");
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                padding: const EdgeInsets.only(
                                                    top: 9,
                                                    bottom: 9,
                                                    left: 10),
                                                color: Colors.white,
                                                height: 30,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    FittedBox(
                                                      child: driveHomeController
                                                          .getFileImage(
                                                              driveHomeController
                                                                  .recentFiles[
                                                                      index]
                                                                  .fileType),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        driveHomeController
                                                            .recentFiles[index]
                                                            .fileName,
                                                        style: const TextStyle(
                                                          fontFamily: "Nanum",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      : const Text("최근에 업로드된 파일이 없습니")))
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

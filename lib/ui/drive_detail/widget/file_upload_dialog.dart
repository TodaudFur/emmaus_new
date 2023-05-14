import 'package:emmaus_new/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drive_controller.dart';
import '../../../data/model/drive_model.dart';

class FileUploadDialog extends StatelessWidget {
  const FileUploadDialog(
      {Key? key,
      required this.fileNameController,
      required this.fileType,
      required this.directory})
      : super(key: key);

  final TextEditingController fileNameController;
  final String fileType;
  final String directory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "파일명 : ",
              style: TextStyle(
                fontSize: 11,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
                child: TextField(
              cursorColor: kSelectColor,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kSelectColor),
                ),
              ),
              controller: fileNameController,
              onChanged: (text) {
                final driveController = Get.put(DriveController());
                driveController.driveModel = DriveModel(
                    fileName: fileNameController.text,
                    fileType: fileType,
                    directory: "$directory/",
                    createAt: DateTime.now(),
                    id: 0,
                    totalDirectory: '');
              },
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w700,
              ),
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text(
              "저장되는 위치 : ",
              style: TextStyle(
                fontSize: 11,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              directory,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

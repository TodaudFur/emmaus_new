import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class FolderUploadDialog extends StatelessWidget {
  const FolderUploadDialog({
    Key? key,
    required this.folderNameController,
    required this.directory,
  }) : super(key: key);

  final TextEditingController folderNameController;
  final String directory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "폴더명 : ",
              style: TextStyle(
                fontSize: 11,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
                child: TextField(
              controller: folderNameController,
              cursorColor: kSelectColor,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kSelectColor),
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w700,
              ),
              inputFormatters: [
                BlankTxt(),
              ],
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

class BlankTxt extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.replaceAll(" ", "_"));
  }
}

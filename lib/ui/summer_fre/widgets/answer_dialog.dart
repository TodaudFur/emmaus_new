import 'package:emmaus_new/controller/summer_fre_22_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerDialog extends StatelessWidget {
  AnswerDialog({Key? key}) : super(key: key);

  final freCR = Get.put(SummerFre22Controller());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        title: const Text(
          "문제 풀기",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Noto',
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '문제 : ${freCR.question}',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Noto',
                ),
              ),
              Text(
                '(입력 기회 : ${freCR.tryTime}/2)',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontFamily: 'Noto',
                ),
              ),
              const Divider(),
              TextField(
                  onSubmitted: (String s) {
                    if (s.isNotEmpty) {
                      freCR.checkAnswer(s);
                      freCR.textController.text = "";
                    }
                  },
                  controller: freCR.textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '정답',
                  )),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text('확인'),
                onPressed: () {
                  if (freCR.textController.text.isNotEmpty) {
                    freCR.checkAnswer(freCR.textController.text);
                    freCR.textController.text = "";
                  }
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text('취소'),
                onPressed: () {
                  freCR.textController.text = "";
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

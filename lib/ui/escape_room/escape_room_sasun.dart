import 'package:emmaus_new/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'escape_room_end.dart';

///사순절 방탈출 문제 페이지

class EscapeRoomSasun extends StatefulWidget {
  const EscapeRoomSasun({super.key});

  @override
  State<EscapeRoomSasun> createState() => _EscapeRoomSasunState();
}

class _EscapeRoomSasunState extends State<EscapeRoomSasun> {
  int roomNum = 1;
  final textController = TextEditingController();

  List<String> hint = [
    "#영어소문자 #다섯글자 #마4:1~11 #예수님 #마귀",
    "#영어소문자 #다섯글자 #마4:17 #예수님 #공생애",
    "#영어소문자 #네글자 #마8:1~17 #예수님 #사역",
    "#영어소문자 #네글자 #마13:1~9 #예수님 #이야기",
    "#영어소문자 #네글자 #마16:16 #예수님 #최고",
    "#숫자 #네자리 #마18:1~4 #예수님 #천국",
    "#숫자 #네자리 #마21:1~11 #예수님 #입장",
    "#영어소문자 #여덟글자 #마22:34~40 #예수님 #제자들",
    "#영어소문자 #다섯글자 #마24:1~24 #예수님 #행동",
    "#영어소문자 #다섯글자 #마26:17~35 #예수님 #음식",
    "#영어소문자 #네글자 #마27:27~56 #예수님 #선물",
    "#영어소문자 #네글자 #마28:1~20 #예수님 #우리",
  ];
  List<String> answer = [
    "tempt",
    "begin",
    "heal",
    "hear",
    "king",
    "5000",
    "1101",
    "neighbor",
    "stand",
    "bread",
    "save",
    "free",
  ];

  @override
  void initState() {
    _getNum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.arrow_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.home),
                      onPressed: () {
                        Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Game()),
                                (route) => false)
                            .then((value) => setState(() {}));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Image.asset(
                                'asset/images/escape_room_$roomNum.png'),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  hint[roomNum - 1],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800],
                                    fontFamily: 'Noto',
                                  ),
                                ),
                              ),
                              const Text(
                                '아래에 정답을 입력해주세요.',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                  onSubmitted: (String s) {
                                    setState(() {
                                      textController.text = "";
                                    });
                                  },
                                  controller: textController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '정답',
                                  )),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kSelectColor,
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 40.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                onPressed: () {
                                  if (textController.text ==
                                      answer[roomNum - 1]) {
                                    Fluttertoast.showToast(
                                        msg: "정답입니다.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    setState(() {
                                      if (roomNum == 12) {
                                        Fluttertoast.showToast(
                                            msg: "방탈출 성공!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EscapeRoomEnd()),
                                        );
                                      } else {
                                        textController.text = "";
                                        roomNum++;
                                        _saveState();
                                      }
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "틀렸습니다.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  }
                                },
                                child: const Text(
                                  "확인",
                                  style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 40.0,
              color: kBodyColor,
            )
          ],
        ),
      ),
    );
  }

  _saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('roomNum', roomNum);
  }

  _getNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("roomNum") != null) {
      if (roomNum != prefs.getInt("roomNum")) {
        setState(() {
          roomNum = prefs.getInt("roomNum")!;
        });
      }
    } else {
      setState(() {
        roomNum = 1;
      });
    }

    print(roomNum);
  }
}

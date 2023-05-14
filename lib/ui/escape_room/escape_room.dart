import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'escape_room_sasun.dart';

class EscapeRoom extends StatefulWidget {
  const EscapeRoom({super.key});

  @override
  State<EscapeRoom> createState() => _EscapeRoomState();
}

class _EscapeRoomState extends State<EscapeRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.arrow_left),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const Divider(
                color: kBodyColor,
              ),
              Padding(
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          '\n안녕하십니까\n엠마오 사순절 방탈출에 오신 여러분을 환영합니다.\n'
                          '사순절 방탈출은 마태복음 기반으로\n예수님의 생애를 경험할 수 있는 방탈출 게임입니다.\n'
                          '각 방은 문제 그림과 정답란으로 구성되어 있습니다.\n'
                          '문제 그림을 잘보고 문제의 정답을 맞히면'
                          '\n다음 방으로 넘어갈 수 있습니다.\n',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                        Image.asset(
                          'asset/images/escape_room_sample.png',
                          height: 300,
                        ),
                        const Text(
                          '위 그림은 예시문제입니다.\n'
                          '위 그림과 비슷한 유형의 그림들이 각 방마다 존재하며,\n'
                          '그림의 정답을 맞히게 되면\n다음 방으로 넘어가게 됩니다.\n'
                          '각 방의 정답은\n"영어 소문자" , "숫자" 로 되어 있습니다.\n'
                          '위 그림의 정답은 "green"이고,\n이유는 네모칸의 색들은 무지개의 색이고,\n"?"자리에 들어갈 색은 녹색이기 때문입니다.\n'
                          '따라서 녹색의 영어인 "green"이 정답이 됩니다.\n'
                          '사순절 방탈출은 총 12개의 방으로 구성되어 있습니다.\n'
                          '그럼 같이 예수님의 생애를 여행해봅시다!\n',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSelectColor,
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EscapeRoomSasun()),
                            );
                          },
                          child: const Text(
                            "시작!",
                            style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                      ],
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
      ),
    );
  }
}

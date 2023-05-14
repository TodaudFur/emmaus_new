import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/constants.dart';

///사도신경, 주기도문, 대표기도, 헌금기도 페이지

class Creeds extends StatefulWidget {
  const Creeds(this.title, {super.key});
  final String title;
  @override
  State<Creeds> createState() => _CreedsState();
}

class _CreedsState extends State<Creeds> {
  final lord = "하늘에 계신 우리 아버지여\n이름이 거룩히 여김을 받으시오며\n"
      "나라이 임하옵시며\n뜻이 하늘에서 이룬 것같이\n땅에서도 이루어지이다.\n"
      "오늘날 우리에게\n일용할 양식을 주옵시고\n"
      "우리가 우리에게\n죄 지은자를 사하여 준 것같이\n"
      "우리 죄를 사하여 주옵시고\n우리를 시험에 들게 하지 마옵시고\n"
      "다만 악에서 구하옵소서.\n"
      "대개 나라와 권세와 영광이\n아버지께 영원히 있사옵나이다. 아멘\n";

  final apostle = "전능하사 천지를 만드신\n하나님 아버지를 내가 믿사오며\n"
      "그 외아들 우리 주\n예수 그리스도를 믿사오니\n"
      "이는 성령으로 잉태 하사\n동정녀 마리아에게 나시고\n"
      "본디오 빌라도에게 고난을 받으사\n십자가에 못 박혀 죽으시고\n"
      "장사한지 사흘만에\n죽은자 가운데서 다시 살아나시며\n"
      "하늘에 오르사\n전능하신 하나님 우편에 앉아 계시다가\n"
      "거기로부터 산 자와 죽은 자를\n심판하러 오시리라.\n"
      "성령을 믿사오며\n거룩한 공교회와 성도가\n서로 교통하는 것과\n"
      "죄를 사하여 주시는 것과\n몸이 다시 사는 것과\n영원히 사는 것을 믿사옵나이다. 아멘\n";

  String pray = "";

  @override
  void initState() {
    if (widget.title == "대표기도" || widget.title == "헌금기도") {
      getPray(widget.title);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        titleTextStyle:
            const TextStyle(fontFamily: 'Noto', color: Colors.black),
        backgroundColor: kBodyColor,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.all(30.0),
              color: kBodyColor,
              child: Stack(
                children: [
                  Text(
                    widget.title == "주기도문"
                        ? lord
                        : widget.title == "사도신경"
                            ? apostle
                            : pray,
                    style: const TextStyle(fontFamily: 'Noto', fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        widget.title == "주기도문"
                            ? "Lord's\nPrayer"
                            : widget.title == "사도신경"
                                ? "Apostle's\nCreed"
                                : "Prayer",
                        style: TextStyle(
                            fontSize: 70,
                            color: Colors.black.withOpacity(0.07)),
                      )),
                ],
              )),
        ),
      ),
    );
  }

  Future getPray(String isPray) async {
    var url = Uri.parse('https://www.official-emmaus.com/emmaus_pray.php');
    var result = await http.post(
      url,
      body: {
        "pray": isPray,
      },
    );
    print(result.body);
    setState(() {
      pray = result.body;
    });
  }
}

import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/summer_23_fre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypingView extends StatefulWidget {
  const TypingView({Key? key}) : super(key: key);

  @override
  State<TypingView> createState() => _TypingViewState();
}

class _TypingViewState extends State<TypingView> {
  List<String> words = [
    '자녀들아 우리가 말과 혀로만 사랑하지 말고',
    '행함과 진실함으로 하자',
    '이로써 우리가 진리에 속한 줄을 알고',
    '또 우리 마음을 주 앞에서 굳세게 하리니',
    '이는 우리 마음이 혹 우리를 책망할 일이 있어도',
    '하나님은 우리 마음보다 크시고',
    '모든 것을 아시기 때문이라',
    '사랑하는 자들아',
    '하나님 앞에서 담대함을 얻고',
    '무엇이든지 구하는 바를 그에게서 받나니',
    '이는 우리가 그의 계명을 지키고',
    '그 앞에서 기뻐하시는 것을 행함이라',
    '그의 계명은 이것이니',
    '곧 그 아들 예수 그리스도의 이름을 믿고',
    '그가 우리에게 주신 계명대로 서로 사랑할 것이니라',
    '그의 계명을 지키는 자는 주 안에 거하고',
    '주는 그의 안에 거하시나니',
    '우리에게 주신 성령으로 말미암아',
    '그가 우리 안에 거하시는 줄을 우리가 아느니라',
  ];
  List<TextEditingController> controllers = [];
  List<FocusNode> nodes = [];
  List<bool?> isCorrects = [];
  List<bool> isEnables = [];

  final freCR = Get.find<Summer23FreController>();

  @override
  void initState() {
    controllers = List.generate(
      words.length,
      (index) => TextEditingController(),
    );
    nodes = List.generate(
      words.length,
      (index) => FocusNode(),
    );

    isCorrects = List.generate(words.length, (index) => null);
    isEnables = List.generate(words.length, (index) => true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: words.length,
              itemBuilder: ((context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      words[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Noto',
                        color: isCorrects[index] == null
                            ? Colors.black
                            : isCorrects[index]!
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: SizedBox(
                        height: 30,
                        child: TextField(
                          controller: controllers[index],
                          focusNode: nodes[index],
                          enabled: isEnables[index],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: kSelectColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kSelectColor),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Noto',
                          ),
                          onSubmitted: (text) {
                            setState(() {
                              controllers[index].text = text;
                              if (text != words[index]) {
                                isCorrects[index] = false;
                              } else if (text == words[index]) {
                                isCorrects[index] = true;
                                freCR.typingSuccess();
                              }
                              isEnables[index] = false;
                            });
                            FocusScope.of(context)
                                .requestFocus(nodes[index + 1]);
                          },
                          cursorHeight: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                );
              })),
        ),
        ElevatedButton(
          onPressed: () {
            if (isEnables.where((element) => element).isEmpty) {
              freCR.typingEnd();
            } else {
              Get.snackbar('Nope', '모든 텍스트를 입력해주세요');
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: kSelectColor),
          child: const Text(
            '제출',
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

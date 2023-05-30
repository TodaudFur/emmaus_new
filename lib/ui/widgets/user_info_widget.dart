import 'package:emmaus_new/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class UserInfoWidget extends StatelessWidget {
  UserInfoWidget({Key? key}) : super(key: key);

  final userCR = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${userCR.userModel.cell} 구역 / ${userCR.userModel.team} 팀 / ${userCR.userModel.term} 기',
          style: const TextStyle(
            fontFamily: 'Noto',
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              backgroundColor: kBodyColor,
            ),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text(
                          "로그아웃",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Noto',
                          ),
                        ),
                        content: const Text(
                          '로그아웃을 하시겠습니까?',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Noto',
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('예'),
                                onPressed: () async {
                                  final result = await userCR.logout();
                                  if (result && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('아니오'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      ));
            },
            child: const Text(
              "로그아웃",
              style: TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w900,
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

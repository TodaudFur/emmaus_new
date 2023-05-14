import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'myhomepage.dart';

///최초 로그인 시에 표시되는 페이지

class FirstLogin extends StatelessWidget {
  FirstLogin({Key? key}) : super(key: key);

  final userCR = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.arrow_left),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                              (route) => false);
                        },
                      ),
                    )),
                Expanded(
                  flex: 95,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(30.0),
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "asset/images/logo_em_3.png",
                            height: 70.0,
                            color: kSelectColor,
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 40.0,
                          ),
                          const Text(
                            "초기 회원정보 변경",
                            style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                                fontSize: 18.0,
                                color: Colors.black),
                          ),
                          const Text(
                            "안전한 사용을 위하여, 회원정보를 변경하여 주시기 바랍니다!\n"
                            "아래에 비밀번호와 이메일을 입력해주시기 바랍니다.\n",
                            style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                                fontSize: 10.0,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                onSubmitted: (String s) {},
                                controller: userCR.psController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '새 비밀번호',
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                onSubmitted: (String s) {},
                                controller: userCR.cpsController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '비밀번호 확인',
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                onSubmitted: (String s) {},
                                controller: userCR.emController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'E-Mail',
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 40.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kSelectColor,
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 40.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            onPressed: () {
                              if (userCR.psController.text ==
                                  userCR.cpsController.text) {
                                userCR.firstChange().then((value) {
                                  Fluttertoast.showToast(
                                      msg: "회원정보가 변경되었습니다. 다시 로그인해주세요!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                  userCR.userModel.isFirst = "True";
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) => false);
                                }).catchError((onError) {
                                  print(onError);
                                  Fluttertoast.showToast(
                                      msg: "회원정보가 변경이 실패하였습니다! 다시 입력해주세요!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "비밀번호가 서로 다릅니다.\n다시 입력해주세요",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0);
                              }
                            },
                            child: const Text(
                              "변경",
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

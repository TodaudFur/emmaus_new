import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/firstlogin.dart';
import 'package:emmaus_new/myhomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'find.dart';

///로그인 페이지

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCR = Get.find<UserController>();
  final loginIdCR = TextEditingController();
  final loginPwdCR = TextEditingController();
  bool autoLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.arrow_left),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
                Expanded(
                  flex: 9,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                onSubmitted: (String s) {},
                                controller: loginIdCR,
                                cursorColor: kSelectColor,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kSelectColor),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kSelectColor,
                                  ),
                                  labelText: 'ID',
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                onSubmitted: (String s) {
                                  Get.dialog(const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                  setState(() {
                                    userCR
                                        .login(loginIdCR.text, loginPwdCR.text)
                                        .then((value) {
                                      Get.back();
                                      if (userCR.userModel.isFirst == "False") {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FirstLogin()),
                                                (route) => false)
                                            .then((value) => setState(() {}));
                                      } else {
                                        print("value : $value");
                                        if (value) {
                                          if (autoLogin) {
                                            userCR.trueAutoLogin(loginIdCR.text,
                                                loginPwdCR.text);
                                          }
                                          Fluttertoast.showToast(
                                              msg: "로그인 성공!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              fontSize: 16.0);
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MyHomePage()),
                                                  (route) => false)
                                              .then((value) => setState(() {}));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "로그인 실패! : 아이디 또는 비밀번호를 확인해주세요.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              fontSize: 16.0);
                                        }
                                      }
                                    }).catchError((onError) {
                                      Fluttertoast.showToast(
                                          msg: "로그인 실패! : 아이디 또는 비밀번호를 확인해주세요.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    });
                                  });
                                },
                                controller: loginPwdCR,
                                obscureText: true,
                                cursorColor: kSelectColor,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kSelectColor),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: kSelectColor,
                                  ),
                                  labelText: 'Password',
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Switch(
                                  value: autoLogin,
                                  activeColor: kSelectColor,
                                  onChanged: (value) {
                                    setState(() {
                                      autoLogin = value;
                                    });
                                  }),
                              const Text(
                                "자동로그인",
                                style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const Find("id");
                                      }));
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: const Text("아이디 찾기"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const Find("pwd");
                                      }));
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: const Text("비밀번호 초기화"),
                                  ),
                                ],
                              ),
                            ],
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
                              Get.dialog(const Center(
                                child: CircularProgressIndicator(),
                              ));
                              setState(() {
                                userCR
                                    .login(loginIdCR.text, loginPwdCR.text)
                                    .then((value) {
                                  Get.back();
                                  if (userCR.userModel.isFirst == "False") {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FirstLogin()),
                                            (route) => false)
                                        .then((value) => setState(() {}));
                                  } else {
                                    if (value) {
                                      if (autoLogin) {
                                        userCR.trueAutoLogin(
                                            loginIdCR.text, loginPwdCR.text);
                                      }
                                      Fluttertoast.showToast(
                                          msg: "로그인 성공!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyHomePage()),
                                              (route) => false)
                                          .then((value) => setState(() {}));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "로그인 실패! : 아이디 또는 비밀번호를 확인해주세요.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }
                                  }
                                }).catchError((onError) {
                                  Fluttertoast.showToast(
                                      msg: "로그인 실패! : 아이디 또는 비밀번호를 확인해주세요.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                });
                              });
                            },
                            child: const Text(
                              "로그인",
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

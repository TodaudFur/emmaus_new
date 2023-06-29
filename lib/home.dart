import 'package:carousel_slider/carousel_slider.dart';
import 'package:emmaus_new/controller/home_controller.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/ui/board_page/widgets/board_row.dart';
import 'package:emmaus_new/ui/mdrive.dart';
import 'package:emmaus_new/ui/summer_23_fre_page/summer_23_fre_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'controller/board_controller.dart';
import 'creeds.dart';
import 'login.dart';

///메인 홈 화면

// List<dynamic> eventFile = [];
// List<dynamic> eventName = [];
// List<dynamic> eventUrl = [];

class Home extends StatefulWidget {
  const Home({Key? key, required this.onTap}) : super(key: key);

  final Function onTap;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeCR = Get.put(HomeController());
  final boardCR = Get.put(BoardController());

  final CarouselController _controller = CarouselController();

  final userCR = Get.find<UserController>();

  @override
  void initState() {
    homeCR.getBulletin(context);
    homeCR.getHomeBoardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kBodyColor,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  "asset/images/logo_ema.png",
                  width: 150,
                ),
              ),
              const Divider(
                color: kBodyColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Obx(
                      () => Text(
                        '안녕하세요 ${userCR.userModel.name}님',
                        style: const TextStyle(
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          flutterDialog();
                        },
                        child: const Icon(
                          CupertinoIcons.doc_text_search,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const MDrive());
                        },
                        child: const Icon(
                          CupertinoIcons.cloud,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    const Text(
                      '엠마오 주보 ',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width,
                        color: kSelectColor.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Obx(
                    () => homeCR.bulletinLoading
                        ? homeCR.bulletinList.isEmpty
                            ? const Text(
                                '404 Jubo Bulluogi Silpae',
                                style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            : CarouselSlider(
                                items: homeCR.bulletinList,
                                carouselController: _controller,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 2),
                                  enlargeCenterPage: true,
                                  aspectRatio: 1.0,
                                  onPageChanged: (index, reason) {},
                                ),
                              )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: kSelectColor,
                            ),
                          ),
                  ),
                ),
              ),
              const Divider(
                color: kBodyColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    const Text(
                      'E-프리퀀시 ',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width,
                          color: kSelectColor.withOpacity(0.2),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSelectColor,
                ),
                onPressed: () {
                  if (userCR.userModel.userId == 0) {
                    Get.snackbar("로그인", "로그인이 필요합니다");
                    Get.to(const LoginPage());
                  } else if (DateTime.now().isAfter(DateTime(2023, 07, 03))) {
                    Get.to(Summer23FrePage());
                  } else {
                    Get.snackbar("Error 404", "7월 3일부터 이용가능합니다!");
                  }
                },
                child: const Text(
                  "입장",
                  style: TextStyle(
                    fontFamily: 'Noto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onTap(1);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        const Text(
                          '게시판 새글 ',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width,
                              color: kSelectColor.withOpacity(0.2),
                            )),
                      ],
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Container(
                  width: Get.width,
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: homeCR.boardList.isEmpty
                            ? const Text(
                                "게시글이 없습니다",
                                style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: homeCR.boardList.length,
                                itemBuilder: (context, index) {
                                  return BoardRow(
                                    post: homeCR.boardList[index].post,
                                    tableName:
                                        homeCR.boardList[index].boardName,
                                    tableType:
                                        homeCR.boardList[index].boardType,
                                  );
                                }),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    const Text(
                      '기도문 ',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width,
                          color: kSelectColor.withOpacity(0.2),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSelectColor,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const Creeds("주기도문");
                          }));
                        },
                        child: const Text(
                          "주기도문",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSelectColor,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const Creeds("사도신경");
                          }));
                        },
                        child: const Text(
                          "사도신경",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSelectColor,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const Creeds("대표기도");
                          }));
                        },
                        child: const Text(
                          "대표기도",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSelectColor,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const Creeds("헌금기도");
                            }));
                          },
                          child: const Text(
                            "헌금기도",
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void flutterDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Text(
              'EMMAUS',
              style: TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const Creeds("주기도문");
                      }));
                    },
                    child: const Text(
                      "주기도문",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const Creeds("사도신경");
                      }));
                    },
                    child: const Text(
                      "사도신경",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const Creeds("대표기도");
                      }));
                    },
                    child: const Text(
                      "대표기도",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const Creeds("헌금기도");
                      }));
                    },
                    child: const Text(
                      "헌금기도",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ],
            ),
          );
        });
  }
}

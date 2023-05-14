import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/point_controller.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/ui/point_mall/widgets/point_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointMall extends StatefulWidget {
  const PointMall({Key? key}) : super(key: key);

  @override
  State<PointMall> createState() => _PointMallState();
}

class _PointMallState extends State<PointMall> {
  final _controller = CarouselController();

  final userCR = Get.find<UserController>();

  final pointCR = Get.find<PointController>();

  @override
  void initState() {
    pointCR.getPointItem();
    pointCR.getEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBodyColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          '엠마오 포인트몰 ',
          style: TextStyle(
              fontFamily: 'Noto', fontWeight: FontWeight.w900, fontSize: 20),
        ),
        actions: [
          Row(
            children: [
              const Icon(CupertinoIcons.money_dollar_circle),
              const SizedBox(
                width: 2,
              ),
              Obx(
                () => Text(userCR.userModel.point.toString()),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            color: kBodyColor,
            padding: const EdgeInsets.only(
                top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
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
                    child: Obx(
                      () => CarouselSlider(
                        items: List.generate(
                          pointCR.eventList.length,
                          (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  '$kBaseUrl/event_banner/${pointCR.eventList[index].thumbnail}',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Container(
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 4),
                            autoPlayAnimationDuration:
                                const Duration(seconds: 2),
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {}),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => pointCR.itemList.isEmpty
                        ? const Text("포인트 상품이 없습니다")
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 30,
                            ),
                            itemCount: pointCR.itemList.length,
                            itemBuilder: (context, index) {
                              return PointItem(item: pointCR.itemList[index]);
                            }),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

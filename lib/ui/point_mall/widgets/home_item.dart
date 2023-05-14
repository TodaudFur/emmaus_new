import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus_new/ui/point_mall/widgets/point_detail_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/point_itme_model.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({Key? key, required this.item}) : super(key: key);

  final PointModel item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(PointDetailPopup(item: item));
      },
      child: Container(
        width: 120,
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
            image: const DecorationImage(
              image: CachedNetworkImageProvider("https://picsum.photos/100"),
            )),
      ),
    );
  }
}

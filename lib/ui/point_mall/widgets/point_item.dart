import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus_new/data/model/point_itme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'point_detail_popup.dart';

class PointItem extends StatelessWidget {
  const PointItem({Key? key, required this.item}) : super(key: key);

  final PointModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Get.dialog(PointDetailPopup(item: item));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: '$kBaseUrl/point_item/${item.thumbnail}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )),
          const SizedBox(
            height: 7,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: kSelectColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              child: const Text(
                "구매",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: "Noto",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

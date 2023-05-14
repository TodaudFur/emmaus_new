import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus_new/data/model/point_itme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class PointDetailPopup extends StatelessWidget {
  const PointDetailPopup({Key? key, required this.item}) : super(key: key);

  final PointModel item;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                width: 300,
                fit: BoxFit.cover,
                imageUrl: '$kBaseUrl/point_itme/${item.detailImage}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                item.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.money_dollar_circle,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    item.price.toString(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: kSelectColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

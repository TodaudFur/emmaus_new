import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/data/model/home_post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../detail_screen.dart';

class HomeController extends GetxController {
  final httpClient = http.Client();

  final _imgList = <String>[].obs;
  List<String> get imgList => _imgList;
  set imgList(val) => _imgList.value = val;

  final _bulletinList = <Widget>[].obs;
  List<Widget> get bulletinList => _bulletinList;
  set bulletinList(val) => _bulletinList.value = val;

  final _isTong = false.obs;
  bool get isTong => _isTong.value;
  set isTong(val) => _isTong.value = val;

  final _bible = '통독'.obs;
  get bible => _bible.value;
  set bible(val) => _bible.value = val;

  final _boardList = <HomePostModel>[].obs;
  List<HomePostModel> get boardList => _boardList;
  set boardList(val) => _boardList.value = val;

  final _bulletinLoading = false.obs;
  bool get bulletinLoading => _bulletinLoading.value;
  set bulletinLoading(val) => _bulletinLoading.value = val;

  getHomeBoardList() async {
    //게시판 불러오기
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_board_home_get.php"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        boardList = jsonResponse['result']
            .map<HomePostModel>((json) => HomePostModel.fromJson(json))
            .toList();
      } else {
        print('Error Select Board');
      }
    } catch (_) {
      print("$_ (Select Board)");
    }
  }

  getBulletin(context) async {
    if (imgList.isEmpty) {
      bulletinLoading = false;
      try {
        final response = await httpClient.get(
          Uri.parse("$kBaseUrl/emmaus_bulletin_json.php"),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          String date = jsonResponse['date'];
          int count = int.parse(jsonResponse['count']);

          for (int i = 0; i < count; i++) {
            imgList.add("$kBaseUrl/bulletin/$date" "_$i.png");
            bulletinList.add(InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(
                    item: imgList,
                    index: i,
                  );
                }));
              },
              child: CachedNetworkImage(
                imageUrl: "$kBaseUrl/bulletin/$date" "_$i.png",
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ));
          }
          _bulletinList.refresh();
          bulletinLoading = true;
          print(bulletinList);
        } else {
          print('Error Select Bulletin');
        }
      } catch (_) {
        bulletinList.clear();
        imgList.clear();
        print("$_ (Select Bulletin)");
      }
    }
  }

  getBible(String id) async {
    print("_id : $id");
    if (DateTime.now().year == 2022) {
      try {
        final response = await httpClient.post(
            Uri.parse(
              "$kBaseUrl/emmaus_bible_init.php",
            ),
            body: {"mb_id": id});
        if (response.statusCode == 200) {
          if (response.body != "null") {
            Map<String, dynamic> jsonResponse = jsonDecode(response.body);
            String chapter = jsonResponse['chapter'];
            String count = jsonResponse['count'];
            bible = chapter + count;
            isTong = jsonResponse['id'] != null ? true : false;
          }
        } else {
          print('Error Select Bible');
        }
      } catch (_) {
        print("$_ (Select Bible)");
      }
    } else {
      bible =
          "D${(DateTime.now().difference(DateTime(2022, 01, 01)).inHours / 24).round()}";
      isTong = false;
    }
  }
}

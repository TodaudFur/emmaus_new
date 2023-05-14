import 'dart:convert';
import 'dart:developer';

import 'package:emmaus_new/data/model/point_event_model.dart';
import 'package:emmaus_new/data/model/point_itme_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class PointController extends GetxController {
  final httpClient = http.Client();

  final _itemList = <PointModel>[].obs;
  List<PointModel> get itemList => _itemList;
  set itemList(val) => _itemList.value = val;

  final _eventList = <EventModel>[].obs;
  List<EventModel> get eventList => _eventList;
  set eventList(val) => _eventList.value = val;

  getHomePoint() async {
    //포인트몰 이벤트 불러오기
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_point_home_get.php"),
      );
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        itemList = jsonResponse['result']
            .map<PointModel>((json) => PointModel.fromJson(json))
            .toList();
        print(itemList);
      } else {
        print('Error Select Point Event');
      }
    } catch (_) {
      print("$_ (Select Point Event)");
    }
  }

  getPointItem() async {
    //포인트몰 아이템 불러오기
    itemList.clear();
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_point_item_get.php"),
      );
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        itemList = jsonResponse['result']
            .map<PointModel>((json) => PointModel.fromJson(json))
            .toList();
        print(itemList);
      } else {
        print('Error Select Point Item');
      }
    } catch (_) {
      print("$_ (Select Point Item)");
    }
  }

  getEvent() async {
    //포인트몰 이벤트 불러오기
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_point_event_get.php"),
      );
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        eventList = jsonResponse['result']
            .map<EventModel>((json) => EventModel.fromJson(json))
            .toList();
        print(itemList);
      } else {
        print('Error Select Point Event');
      }
    } catch (_) {
      print("$_ (Select Point Event)");
    }
  }
}

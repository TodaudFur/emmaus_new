import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../data/model/user_model.dart';

class UserController extends GetxController {
  final httpClient = http.Client();

  final _userModel = UserModel(
    id: "id",
    name: "엠마오",
    cell: "cell",
    team: "team",
    term: "term",
    isFirst: "isFirst",
    special: 0,
    normal: 0,
    userId: 0,
    point: 0,
  ).obs;
  UserModel get userModel => _userModel.value;
  set userModel(val) => _userModel.value = val;

  userUpdate() {
    _userModel.refresh();
  }

  final _iconsList = [
    kFalseSpecial,
    kFalseSpecial,
    kFalseSpecial,
    kFalseNormal,
    kFalseNormal,
    kFalseNormal,
    kFalseNormal,
    kFalseNormal,
    kFalseNormal,
  ].obs;
  List<Widget> get iconsList => _iconsList;
  set iconsList(val) => _iconsList.value = val;

  iconUpdate() {
    _iconsList.refresh();
  }

  final _isCheck = false.obs;
  get isCheck => _isCheck.value;
  set isCheck(val) => _isCheck.value = val;

  Future<bool> login(String id, String password) async {
    try {
      final response =
          await http.post(Uri.parse('$kBaseUrl/app_login_check.php'), body: {
        "mb_id": id,
        "mb_password": password,
      });

      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        userModel = UserModel.fromJson(jsonResponse);
        getQt(id);
        for (int i = 0; i < 3; i++) {
          if (i < userModel.special) {
            iconsList[i] = kTrueSpecial;
          } else {
            iconsList[i] = kFalseSpecial;
          }
        }
        for (int i = 3; i < 9; i++) {
          if (i < userModel.normal) {
            iconsList[i] = kTrueNormal;
          } else {
            iconsList[i] = kFalseNormal;
          }
        }
        return true;
      }
    } catch (e) {
      print("exception : $e");
    }
    return false;
  }

  getQt(String mbId) async {
    var url = Uri.parse('$kBaseUrl/emmaus_qt_init.php');
    var result = await http.post(url, body: {"mb_id": mbId});

    print(result.body);

    if (result.body != "null") {
      isCheck = true;
    }
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setBool("autologin", false);
    if (result) {
      userModel = UserModel(
        id: "id",
        name: "엠마오",
        cell: "cell",
        team: "team",
        term: "term",
        isFirst: "isFirst",
        special: 0,
        normal: 0,
        userId: 0,
        point: 0,
      );
      return true;
    } else {
      return false;
    }
  }

  ///first login var, functions

  final emController = TextEditingController();
  final psController = TextEditingController();
  final cpsController = TextEditingController();

  firstChange() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_password_process.php');
    var result = await http.post(url, body: {
      "mb_name": userModel.name,
      "password": psController.text,
      "email": emController.text
    });

    print(result.body);
  }

  ///login var, functions

  void trueAutoLogin(String id, String pwd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("autologin", true);
    await prefs.setString("autoid", id);
    await prefs.setString("autopwd", pwd);
  }
}

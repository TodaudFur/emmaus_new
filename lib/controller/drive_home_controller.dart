import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../constants.dart';
import '../data/model/drive_model.dart';
import '../data/model/recent_file_model.dart';

class DriveHomeController extends GetxController {
  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;
  set isLogin(val) => _isLogin.value = val;

  String getUpload(String type) {
    if (recentFile.isNotEmpty) {
      if (recentFile.where((element) => element.type == type).isEmpty) {
        return "최근 업로드가 없음";
      } else {
        int days = recentFile
            .where((element) => element.type == type)
            .first
            .createAt
            .difference(DateTime.now())
            .inDays;
        if (days != 0) {
          days = -days;
          return "$days 일전 업로드됨";
        } else {
          return "오늘 업로드됨";
        }
      }
    } else {
      return "최근 업로드가 없음";
    }
  }

  final _recentFile = <RecentFileModel>[].obs;
  List<RecentFileModel> get recentFile => _recentFile;
  set recentFile(val) => _recentFile.value = val;

  getRecentFile() async {
    try {
      final response = await http
          .post(Uri.parse('$kBaseUrl/emmaus_recent_file.php'), body: {});
      print("Get Recent File Response : ${response.body}");
      if (response.statusCode == 200) {
        print(parseResponse(response.body));
        recentFile = parseResponse(response.body);
        print(recentFile.map((e) => e.type));
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  static List<RecentFileModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RecentFileModel>((json) => RecentFileModel.fromJson(json))
        .toList();
  }

  final _recentFiles = <DriveModel>[].obs;
  List<DriveModel> get recentFiles => _recentFiles;
  set recentFiles(val) => _recentFiles.value = val;

  getRecentFile7Days() async {
    try {
      final response = await http
          .post(Uri.parse('$kBaseUrl/emmaus_recent_7days.php'), body: {});
      print("Get Recent 7Days Files Response : ${response.body}");
      if (response.statusCode == 200) {
        recentFiles = parse7DaysResponse(response.body);
        print(recentFiles);
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  static List<DriveModel> parse7DaysResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DriveModel>((json) => DriveModel.fromJson(json)).toList();
  }

  Widget getFileImage(String fileType) {
    if (fileType == 'folder') {
      return Image.asset(
        "asset/images/folder.png",
        width: 30,
      );
    } else {
      final mimeType = lookupMimeType(".$fileType");
      print(mimeType);
      switch (mimeType!.split("/").first) {
        case "image":
          return const Text(
            "IMG",
            style: TextStyle(color: Color(0xFFFE7301)),
          );
        case "video":
          return const Text(
            "VIDEO",
            style: TextStyle(color: Color(0xFF8800FF)),
          );

        case "text":
          return const Text(
            "TXT",
            style: TextStyle(color: Colors.black),
          );

        case "application":
          switch (mimeType.split("/").last) {
            case "vnd.ms-excel":
            case "vnd.openxmlformats-officedocument.spreadsheetml.sheet":
              return const Text(
                "XLS",
                style: TextStyle(color: Color(0xFF0A783F)),
              );

            case "pdf":
              return const Text(
                "PDF",
                style: TextStyle(color: Color(0xFFDE0202)),
              );

            default:
              return const Text(
                "DOC",
                style: TextStyle(color: Color(0xFF0000D5)),
              );
          }
        default:
          return Container();
      }
    }
  }
}

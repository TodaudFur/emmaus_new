import 'dart:convert';
import 'dart:developer';

import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/data/model/board_model.dart';
import 'package:emmaus_new/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class BoardController extends GetxController {
  final httpClient = http.Client();

  final _boardList = <BoardModel>[].obs;
  List<BoardModel> get boardList => _boardList;
  set boardList(val) => _boardList.value = val;

  final _postList = <PostModel>[].obs;
  List<PostModel> get postList => _postList;
  set postList(val) => _postList.value = val;

  final _postGetLoading = false.obs;
  bool get postGetLoading => _postGetLoading.value;
  set postGetLoading(val) => _postGetLoading.value = val;

  final _postHasReachedMax = false.obs;
  get postHasReachedMax => _postHasReachedMax.value;
  set postHasReachedMax(val) => _postHasReachedMax.value = val;

  final _cellPeople = <String>[].obs;
  List<String> get cellPeople => _cellPeople;
  set cellPeople(val) => _cellPeople.value = val;

  final userCR = Get.find<UserController>();

  getBoardList() async {
    //게시판 불러오기
    boardList.clear();
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_board_get.php"),
      );
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        boardList = jsonResponse['result']
            .map<BoardModel>((json) => BoardModel.fromJson(json))
            .toList();
        print(boardList);
      } else {
        print('Error Select Board');
      }
    } catch (_) {
      print("$_ (Select Board)");
    }
  }

  getPostList({
    required String tableType,
    int startIndex = 0,
    int limitCount = 25,
  }) async {
    //게시판 불러오기
    if (startIndex == 0) {
      postList.clear();
      postGetLoading = false;
      postHasReachedMax = false;
    }
    if (!postHasReachedMax) {
      try {
        final response = await httpClient
            .post(Uri.parse("$kBaseUrl/emmaus_post_list_get.php"), body: {
          "tableType": tableType,
          "startIndex": startIndex.toString(),
          "limitCount": limitCount.toString(),
        });
        log(response.body);
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          if (jsonResponse['result'].isEmpty) {
            postHasReachedMax = true;
          } else {
            postList.addAll(jsonResponse['result']
                .map<PostModel>((json) => PostModel.fromJson(json))
                .toList());
            if (postList.length < limitCount) {
              postHasReachedMax = true;
            }
          }
          if (!postGetLoading) {
            postGetLoading = true;
          }
          print(boardList);
        } else {
          print('Error Select Post');
        }
      } catch (_) {
        print("$_ (Select Post)");
      }
    }
  }

  postWrite(
      {required String title,
      required String content,
      bool? isSecret,
      String? cell,
      required String tableType}) async {
    //게시글 쓰기
    Get.dialog(const Center(child: CircularProgressIndicator()));

    try {
      final response = await httpClient.post(
        Uri.parse("$kBaseUrl/emmaus_post_write.php"),
        body: {
          "title": title,
          "content": content,
          "isSecret": "0",
          "userId": userCR.userModel.id,
          "tableType": tableType,
          "cell": cell ?? "",
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        if (response.body == "1") {
          Get.back();
          Get.back();
          getPostList(tableType: tableType);
        }
      } else {
        print('Error Write Post');
      }
    } catch (_) {
      print("$_ (Write Post)");
    }
  }

  Future<bool?> getCellPeople({required String cell}) async {
    //셀원 불러오기
    try {
      final response = await httpClient.post(
        Uri.parse("$kBaseUrl/emmaus_cell_people_get.php"),
        body: {
          "cell": cell,
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        cellPeople = List<String>.from(jsonResponse['result']);
        print(cellPeople);
        return true;
      } else {
        print('Error Select Cell People');
      }
    } catch (_) {
      print("$_ (Select Cell People)");
    }
    return null;
  }

  Future<bool> postLike(int postId, String boardType) async {
    //게시글 좋아요
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierColor: Colors.white.withOpacity(0.2), barrierDismissible: false);
    try {
      final response = await httpClient
          .post(Uri.parse("$kBaseUrl/emmaus_board_like.php"), body: {
        'postId': postId.toString(),
        'boardType': boardType,
      });
      Get.back();
      log(response.body);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        if (jsonDecode(response.body)['result']) {
          print("It is True");

          return true;
        }
      } else {
        print('Error Like Post');
      }
    } catch (_) {
      print("$_ (Like Post)");
    }
    return false;
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:emmaus_new/constants.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:emmaus_new/data/model/bible_question_model.dart';
import 'package:emmaus_new/data/model/ox_question_model.dart';
import 'package:emmaus_new/data/model/ranking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Summer23FreController extends GetxController {
  final httpClient = http.Client();

  final _selectedType = ''.obs;
  get selectedType => _selectedType.value;
  set selectedType(val) => _selectedType.value = val;

  final _score = 0.obs;
  int get score => _score.value;
  set score(val) => _score.value = val;

  final _tmpScore = 0.obs;
  int get tmpScore => _tmpScore.value;
  set tmpScore(val) => _tmpScore.value = val;

  final _bibleQuestion =
      BibleQuestionModel(question: 'question', answer: 'answer').obs;
  BibleQuestionModel get bibleQuestion => _bibleQuestion.value;
  set bibleQuestion(val) => _bibleQuestion.value = val;

  final _oxQuestion = <OXQuestionModel>[].obs;
  List<OXQuestionModel> get oxQuestion => _oxQuestion;
  set oxQuestion(val) => _oxQuestion.value = val;

  final _oxStep = 0.obs;
  int get oxStep => _oxStep.value;
  set oxStep(val) => _oxStep.value = val;

  final _bibleTicket = true.obs;
  bool get bibleTicket => _bibleTicket.value;
  set bibleTicket(val) => _bibleTicket.value = val;

  final _oxTicket = true.obs;
  bool get oxTicket => _oxTicket.value;
  set oxTicket(val) => _oxTicket.value = val;

  final _rankList = <RankingModel>[].obs;
  List<RankingModel> get rankList => _rankList;
  set rankList(val) => _rankList.value = val;

  final _myRank = 0.obs;
  int get myRank => _myRank.value;
  set myRank(val) => _myRank.value = val;

  final _oxIsCorrect = Rx<bool?>(null);
  bool? get oxIsCorrect => _oxIsCorrect.value;
  set oxIsCorrect(val) => _oxIsCorrect.value = val;

  final bibleTC = TextEditingController();

  getScore() async {
    final prefs = await SharedPreferences.getInstance();
    final key = DateFormat('yyyyMMdd').format(DateTime.now());
    final bibleResult = prefs.getBool("bible$key");
    if (bibleResult != null) {
      bibleTicket = false;
    }
    final oxResult = prefs.getBool("ox$key");
    if (oxResult != null) {
      oxTicket = false;
    }

    final userCR = Get.find<UserController>();
    try {
      final response = await httpClient
          .post(Uri.parse("$kBaseUrl/emmaus_23_fre_score_get.php"), body: {
        'id': userCR.userModel.userId.toString(),
      });
      if (response.statusCode == 200) {
        print('Get ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        score = int.parse(jsonResponse['score']);
      } else {
        print('Error Get Score ${response.body}');
      }
    } catch (_) {
      print("$_ (Get Score)");
    }
  }

  getRanking() async {
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_23_fre_ranking_get.php"),
      );

      if (response.statusCode == 200) {
        log('Get ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        rankList = jsonResponse['result']
            .map<RankingModel>((json) => RankingModel.fromJson(json))
            .toList();
        myRank = int.parse(jsonResponse['myRank']);
      } else {
        print('Error Get Rank ${response.body}');
      }
    } catch (_) {
      print("$_ (Get Rank)");
    }
  }

  enterBible() async {
    final prefs = await SharedPreferences.getInstance();
    final key = DateFormat('yyyyMMdd').format(DateTime.now());
    final result = prefs.getBool("bible$key");

    if (result != null) {
      Get.snackbar('Error 404', '오늘 문제 풀이 기회는 끝났습니다. 내일 이용해주세요.');
    } else {
      selectBibleQuestion();
    }
  }

  enterOX() async {
    final prefs = await SharedPreferences.getInstance();
    final key = DateFormat('yyyyMMdd').format(DateTime.now());
    final result = prefs.getBool("ox$key");

    if (result != null) {
      Get.snackbar('Error 404', '오늘 문제 풀이 기회는 끝났습니다. 내일 이용해주세요.');
    } else {
      selectOXQuestion();
    }
  }

  selectBibleQuestion() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_23_fre_bible_get.php"),
      );
      if (response.statusCode == 200) {
        print('Get ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        bibleQuestion = BibleQuestionModel.fromJson(jsonResponse['result'][0]);
        Get.back();
        selectType('말씀 문제 풀기');
      } else {
        Get.back();
        print('Error Get Bible');
      }
    } catch (_) {
      Get.back();
      print("$_ (Get Bible)");
    }
  }

  selectOXQuestion() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    try {
      final response = await httpClient.get(
        Uri.parse("$kBaseUrl/emmaus_23_fre_ox_get.php"),
      );
      if (response.statusCode == 200) {
        print('Get ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        oxQuestion = jsonResponse['result']
            .map<OXQuestionModel>((json) => OXQuestionModel.fromJson(json))
            .toList();
        Get.back();
        selectType('OX 문제 풀기');
      } else {
        Get.back();
        print('Error Get OX');
      }
    } catch (_) {
      Get.back();
      print("$_ (Get OX)");
    }
  }

  selectBack() {
    selectedType = '';
    tmpScore = 0;
  }

  selectType(String type) => selectedType = type;

  typingSuccess() => tmpScore++;

  typingEnd() {
    score += tmpScore;
    scoreSave();
  }

  bibleCheck(bool isCorrect) async {
    final prefs = await SharedPreferences.getInstance();
    final key = DateFormat('yyyyMMdd').format(DateTime.now());
    prefs.setBool("bible$key", true);
    bibleTicket = false;
    if (isCorrect) {
      score++;
      scoreSave();
      Get.snackbar('정답', '내일도 공개되는 문제도 파이팅!');
    } else {
      Get.snackbar('오답', '내일은 맞춰봅시다!');
    }
  }

  oxCheck(bool isCorrect) async {
    oxIsCorrect = isCorrect;

    if (isCorrect) {
      tmpScore++;
    }
    await Future.delayed(
      const Duration(milliseconds: 800),
    );
    oxIsCorrect = null;
    if (oxStep == 4) {
      final prefs = await SharedPreferences.getInstance();
      final key = DateFormat('yyyyMMdd').format(DateTime.now());
      prefs.setBool('ox$key', true);
      oxTicket = false;
      score += tmpScore;
      Get.snackbar('End', '$tmpScore 개의 정답을 맞췄습니다!\n내일도 재밌는 문제로 함께 해요!');
      scoreSave();
    } else {
      oxStep++;
    }
  }

  scoreSave() async {
    final userCR = Get.find<UserController>();
    try {
      final response = await httpClient
          .post(Uri.parse("$kBaseUrl/emmaus_23_fre_score_save.php"), body: {
        'id': userCR.userModel.userId.toString(),
        'score': score.toString(),
      });
      if (response.statusCode == 200) {
        print('Success Save Score');
        tmpScore = 0;
        selectedType = '';
      } else {
        print('Error Save Score');
      }
    } catch (_) {
      print("$_ (Save Score)");
    }
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:emmaus_new/data/model/verse_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class VerseController extends GetxController {
  final httpClient = http.Client();

  @override
  void onInit() {
    getVerse();
    super.onInit();
  }

  final _todayVerse = VerseModel(english: '', korean: '').obs;
  VerseModel get todayVerse => _todayVerse.value;
  set todayVerse(val) => _todayVerse.value = val;

  final screenshotController = ScreenshotController();

  getVerse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList(DateFormat('MMdd').format(DateTime.now())) ==
        null) {
      try {
        final response = await httpClient.get(
          Uri.parse("$kBaseUrl/emmaus_today_verse_get.php"),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          print("Select Today Verse : ${jsonResponse['result']}");
          todayVerse = VerseModel.fromJson(jsonResponse['result']);
          await prefs.setStringList(DateFormat('MMdd').format(DateTime.now()),
              [todayVerse.english, todayVerse.korean]);
        } else {
          print('Error Select Today Verse');
        }
      } catch (_) {
        print("$_ (Select Today Verse)");
      }
    } else {
      final result =
          prefs.getStringList(DateFormat('MMdd').format(DateTime.now()));
      todayVerse =
          VerseModel.fromJson({'english': result![0], 'korean': result[1]});
    }
    print(todayVerse.toJson());
  }

  void takeScreenshot() async {
    _requestPermission();
    screenshotController
        .capture(delay: const Duration(milliseconds: 30))
        .then((Uint8List? image) async {
      final result = await ImageGallerySaver.saveImage(image!,
              quality: 60,
              name:
                  DateFormat("yyyy_MM_dd").format(DateTime.now()).toString()) +
          "Emmaus";
      print(result);
    }).catchError((onError) {
      print(onError);
    });
    Get.snackbar('성공', '사진이 저장되었습니다!');
  }

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      print('Storage permission is granted.');
      return true;
    } else {
      print('Storage permission is not granted.');
      return false;
    }
  }
}

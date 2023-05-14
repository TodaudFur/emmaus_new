import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:emmaus_new/controller/user_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'firebase_options.dart';
import 'myhomepage.dart';

///Main

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String routeFromMessage = "";
  final userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    autoLogin();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.getToken().then((value) => tokenInit(value!));

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        Get.defaultDialog(
            title: message.notification!.title!,
            content: Text(
              message.notification!.body!,
              style: const TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      routeFromMessage = message.data["route"];
      _launchURL(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Emmaus',
        theme: ThemeData(
            primaryColor: kBodyColor,
            scaffoldBackgroundColor: kBodyColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: kSelectColor,
              selectionColor: kSelectColor.withOpacity(0.2),
              selectionHandleColor: kSelectColor,
            )),
        home: AnimatedSplashScreen(
          duration: 500,
          splash: const Image(
            image: AssetImage('asset/images/logo_em2_txt.png'),
          ),
          nextScreen: const MyHomePage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
        ));
  }

  _launchURL(String url) async {
    await canLaunchUrl(Uri.parse(url))
        ? await launchUrl(Uri.parse(url))
        : throw 'Could not launch $url';
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? al = prefs.getBool("autologin");
    print(al);
    if (al! && (userController.userModel.userId == 0)) {
      String? id = prefs.getString("autoid");
      String? pwd = prefs.getString("autopwd");
      userController.login(id!, pwd!).then((value) {
        if (value) {
          Navigator.of(context)
              .pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (route) => false)
              .then((value) => setState(() {}));
        } else {}
      }).catchError((onError) {});
    }
  }

  tokenInit(String token) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    print(deviceInfo.deviceInfo);
    String userPhone = "";
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      print("android : ${androidInfo.id}");
      userPhone = androidInfo.id;
    } else {
      final iosInfo = await deviceInfo.iosInfo;
      print("ios : ${iosInfo.name}");
    }
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_firebase_token_init.php');
    var result =
        await http.post(url, body: {"userPhone": userPhone, "token": token});

    print(result.body);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

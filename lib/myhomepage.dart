import 'package:emmaus_new/ui/board_page/board_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'home.dart';
import 'settings.dart';
import 'todayverse.dart';

///BottomNavigationBar 를 사용한 페이지

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = [];

  final picker = ImagePicker();
  bool isOpen = false;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      widgetOptions = [
        Home(
          onTap: onItemTapped,
        ),
        const BoardPage(),
        const Text(
          'Oops!\nMADE BY 404',
          style: TextStyle(
            color: Colors.black26,
            fontSize: 50,
          ),
        ),
        TodayVerse(),
        const Settings(),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBodyColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: _launchURL,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.0,
                  ),
                  shape: BoxShape.circle,
                  color: kSelectColor),
              child: Center(
                child: Tab(
                    icon: Image.asset(
                  "asset/images/logo_em_3.png",
                  scale: 4.0,
                )),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: MediaQuery.of(context).size.height / 30,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wysiwyg),
                label: '게시판',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    null,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book_fill),
                label: '오늘의 말씀',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '더보기',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedLabelStyle: const TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w500,
                fontSize: 10.0),
            selectedLabelStyle: const TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
                fontSize: 10.0),
            selectedItemColor: kSelectColor,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://youtube.com/channel/UChKWnwNuFsgzZ1pIwVnPCvA';
    await canLaunchUrl(Uri.parse(url))
        ? await launchUrl(Uri.parse(url))
        : throw 'Could not launch $url';
  }
}

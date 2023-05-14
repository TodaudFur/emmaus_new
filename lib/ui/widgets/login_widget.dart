import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../login.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: kBodyColor,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            "로그인",
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.w900,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}

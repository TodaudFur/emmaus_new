import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseReward extends StatelessWidget {
  const ChooseReward({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              CupertinoIcons.gift_fill,
              color: Colors.green[700],
            ),
            const Text(
              "경품선택",
              style: TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

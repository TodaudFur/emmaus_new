import 'package:flutter/material.dart';

class QTProgress extends StatelessWidget {
  const QTProgress({
    Key? key,
    required this.progress,
  }) : super(key: key);
  final int progress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "오늘의 큐티 출석 현황 $progress%",
              style: const TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}

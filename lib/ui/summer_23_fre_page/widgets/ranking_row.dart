import 'package:emmaus_new/data/model/ranking_model.dart';
import 'package:flutter/material.dart';

class RankingRow extends StatelessWidget {
  const RankingRow({Key? key, required this.rank}) : super(key: key);

  final RankingModel rank;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '${rank.rank}위',
                style: TextStyle(
                  fontSize: rank.rank < 4 ? 14 : 12,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Noto',
                  color: rank.rank == 1
                      ? const Color(0xFFD5A11E)
                      : rank.rank == 2
                          ? const Color(0xFFA3A3A3)
                          : rank.rank == 3
                              ? const Color(0xFFCD7F32)
                              : Colors.black,
                ),
              ),
              SizedBox(
                width: rank.rank < 4 ? 7 : 10,
              ),
              Text(
                '${rank.name}님',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Noto',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              text: '',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Noto',
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: rank.score.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const TextSpan(text: '점'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '/constants.dart';
//
// ///통독현황 페이지
// ///현재 사용 X
//
// class BibleAll extends StatefulWidget {
//   const BibleAll({super.key});
//
//   @override
//   State<BibleAll> createState() => _BibleAllState();
// }
//
// class _BibleAllState extends State<BibleAll> {
//   List<dynamic> date = [];
//   List<dynamic> chapter = [];
//   List<dynamic> count = [];
//   List<dynamic> isCheck = [];
//
//   @override
//   void initState() {
//     VarData().getAllBible().then((value) {
//       print(value['isCheck']);
//       setState(() {
//         date = value['date']!;
//         chapter = value['chapter']!;
//         count = value['count']!;
//         isCheck = value['isCheck']!;
//       });
//     });
//     super.initState();
//   }
//
//   Future<Map<String, List<dynamic>>> getAllBible() async {
//     var url = Uri.parse(
//         'https://www.official-emmaus.com/g5/bbs/emmaus_bible_all_init.php');
//     print(userController.userModel.id);
//     var result = await http.post(url, body: {
//       "mb_id": userController.userModel.id,
//     });
//
//     print(result.body);
//     Map<String, dynamic> body = json.decode(result.body);
//
//     return {
//       "date": body['date'],
//       "chapter": body['chapter'],
//       "count": body['count'],
//       "isCheck": body['isCheck']
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 100,
//                 alignment: Alignment.centerLeft,
//                 child: IconButton(
//                   icon: const Icon(CupertinoIcons.arrow_left),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//               child: FittedBox(
//                 child: Text(
//                   "통독표",
//                   style: TextStyle(
//                     fontFamily: 'Nanum',
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ),
//             ),
//             const Divider(
//               color: kBodyColor,
//             ),
//             Expanded(
//                 child: ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: date.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Container(
//                         padding: const EdgeInsets.only(left: 10, right: 10),
//                         alignment: Alignment.topLeft,
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                                     color: Colors.black.withOpacity(0.1)))),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 date[index],
//                                 style: const TextStyle(
//                                   fontFamily: 'Nanum',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "${chapter[index]} ${count[index]}",
//                                 style: const TextStyle(
//                                   fontFamily: 'Nanum',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                             Checkbox(
//                               onChanged: null,
//                               value: isCheck[index] == null ? false : true,
//                               activeColor: kSelectColor,
//                             ),
//                           ],
//                         ),
//                       );
//                     })),
//           ],
//         ),
//       ),
//     );
//   }
// }

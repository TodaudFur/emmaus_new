import 'package:emmaus_new/data/model/leader_model.dart';

class EmmausModel {
  String sundayTime;
  String wlbTime;
  String seniorPastor;
  String pastor;
  String elder;
  List<LeaderModel> leaders;

  EmmausModel({
    required this.sundayTime,
    required this.wlbTime,
    required this.seniorPastor,
    required this.pastor,
    required this.elder,
    required this.leaders,
  });

  factory EmmausModel.fromJson(Map<String, dynamic> json) {
    return EmmausModel(
      sundayTime: json['sundayTime'],
      wlbTime: json['wlbTime'],
      seniorPastor: json['seniorPastor'],
      pastor: json['pastor'],
      elder: json['elder'],
      leaders: json['leader']
          .map<LeaderModel>((json) => LeaderModel.fromJson(json))
          .toList(),
    );
  }
}

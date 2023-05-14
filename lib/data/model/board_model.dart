import 'package:emmaus_new/data/model/post_model.dart';

class BoardModel {
  String tableType;
  String tableName;
  List<PostModel> postList;

  BoardModel({
    required this.tableType,
    required this.tableName,
    required this.postList,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      tableType: json['tableType'],
      tableName: json['tableName'],
      postList: json['postList']
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList(),
    );
  }
}

import 'package:emmaus_new/data/model/post_model.dart';

class HomePostModel {
  PostModel post;
  String boardName;
  String boardType;

  HomePostModel({
    required this.post,
    required this.boardName,
    required this.boardType,
  });

  factory HomePostModel.fromJson(Map<String, dynamic> json) {
    return HomePostModel(
      post: PostModel.fromJson(json['post']),
      boardName: json['boardName'] ?? '',
      boardType: json['boardType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'post': post,
        'boardName': boardName,
        'boardType': boardType,
      };
}

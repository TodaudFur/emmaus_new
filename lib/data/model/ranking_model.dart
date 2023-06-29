class RankingModel {
  String name;
  int score;
  int rank;

  RankingModel({
    required this.name,
    required this.score,
    required this.rank,
  });

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      name: json['name'],
      score: int.parse(json['score']),
      rank: int.parse(json['rank']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'score': score,
        'rank': rank,
      };
}

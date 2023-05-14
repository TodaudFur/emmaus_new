class UserModel {
  int userId;
  String id;
  String name;
  String cell;
  String team;
  String term;
  String isFirst;
  int special;
  int normal;
  int point;

  UserModel({
    required this.userId,
    required this.id,
    required this.name,
    required this.cell,
    required this.team,
    required this.term,
    required this.isFirst,
    required this.special,
    required this.normal,
    required this.point,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: int.parse(json['userId']),
      id: json['id'],
      name: json['name'],
      cell: json['cell'],
      team: json['team'],
      term: json['term'],
      isFirst: json['isFirst'],
      special: int.parse(json['special']),
      normal: int.parse(json['normal']),
      point: int.parse(json['point']),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'cell': cell,
        'team': team,
        'term': term,
        'isFirst': isFirst,
        'special': special,
        'normal': normal,
        'point': point,
      };
}

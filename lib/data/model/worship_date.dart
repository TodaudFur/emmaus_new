class WorshipDateModel {
  String date;
  int startTime;
  int endTime;

  WorshipDateModel({
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory WorshipDateModel.fromJson(Map<String, dynamic> json) {
    return WorshipDateModel(
      date: json['date'],
      startTime: int.parse(json['startTime']),
      endTime: int.parse(json['endTime']),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
      };
}

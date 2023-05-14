import 'drive_model.dart';

class DriveHomeModel {
  int dayCount;
  List<DriveModel> last7DaysFiles;

  DriveHomeModel({
    required this.dayCount,
    required this.last7DaysFiles,
  });

  factory DriveHomeModel.fromJson(Map<String, dynamic> json) {
    return DriveHomeModel(
      dayCount: int.parse(json['dayCount']),
      last7DaysFiles: json['last7DaysFiles'],
    );
  }

  Map<String, dynamic> toJson() => {
        'dayCount': dayCount,
        'last7DaysFiles': last7DaysFiles,
      };
}

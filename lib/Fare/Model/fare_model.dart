import 'package:fair_calculator_driver/packages.dart';

class FareModel {
  final String? fareUID;
  final DateTime? fareDate;
  final String? fareDistance;
  RxDouble fareBaseRate = 0.0.obs;
  RxDouble fareRate = 0.0.obs;

  FareModel({this.fareUID, this.fareDate, this.fareDistance});

  FareModel.fromJSON(Map<String, dynamic> json, String id)
      : this(
          fareUID: id,
          fareDate: (json['fare_date'] as Timestamp).toDate(),
          fareDistance: json['fare_distance'] as String,
        );
}

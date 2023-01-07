import 'package:fair_calculator_driver/packages.dart';

class HistoryModel {
  final String? historyID;
  final String? historyUserID;
  final String? historyDistance;
  final String? historyDuration;
  final double? historyFare;
  final LatLng? historyStartPoint;
  final LatLng? historyEndPoint;
  final DateTime? historyStartTrip;
  final DateTime? historyEndTrip;
  final int? historyNumberOfPassenger;

  HistoryModel({
    this.historyID,
    this.historyUserID,
    this.historyDistance,
    this.historyDuration,
    this.historyFare,
    this.historyStartPoint,
    this.historyEndPoint,
    this.historyStartTrip,
    this.historyEndTrip,
    this.historyNumberOfPassenger,
  });

  HistoryModel.toJson(Map<String, dynamic> res, String id)
      : this(
          historyID: id,
          historyUserID: res['history_userID'] as String,
          historyDistance: res['history_distance'] as String,
          historyDuration: res['history_duration'] as String,
          historyFare: res['history_fare'] as double,
          historyStartPoint:
              convertGeoPoint(res['history_start_point'] as GeoPoint),
          historyEndPoint:
              convertGeoPoint(res['history_end_point'] as GeoPoint),
          historyStartTrip: convertTs(res['history_start_trip'] as Timestamp),
          historyEndTrip: convertTs(res['history_end_trip'] as Timestamp),
          historyNumberOfPassenger: res['history_number_passenger'] as int,
        );

  //Additional fee for number of passenger
  double additionalFee() =>
      historyNumberOfPassenger! > 2 ? (historyNumberOfPassenger! - 2) * 5 : 0;

  String additionNameFee() => PriceClass().priceFormat(additionalFee());

  String getDate() =>
      DateFormatClass.getDateTime(historyStartTrip!).getTodayDateToString();

  String getTimeStart() =>
      DateFormatClass.getDateTime(historyStartTrip!).getCurrentTimeToString();
}
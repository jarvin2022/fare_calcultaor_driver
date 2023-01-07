import 'package:fair_calculator_driver/packages.dart';

class TransactionModel {
  final String? transactionID;
  LatLng? transactionStartLocation;
  LatLng? transactionEndLocation;
  final RxString transactionDistance = '0 m'.obs;
  final RxString transactionDuration = '0 ms'.obs;
  final RxDouble transactionFare = 0.0.obs;
  final RxBool? status ;
  DateTime startDate = DateTime.now();
  final int? numberOfPassenger;
  
  //Base rate
  RxDouble transactionBaseRate = 0.0.obs;

  //Additional Rate
  RxDouble transactionRate = 0.0.obs;

  TransactionModel(
      {this.transactionID,
      this.transactionEndLocation,this.transactionStartLocation,this.status,this.numberOfPassenger});

  TransactionModel.fromJSON(Map<String, dynamic> json, String id, LatLng start, LatLng end)
      : this(
          transactionID: id,
          transactionStartLocation: start,
          transactionEndLocation: end,
          status: RxBool(json['transaction_status'] as bool).obs(),
          numberOfPassenger: json['transaction_passenger_qty'] as int >  2? ((json['transaction_passenger_qty'] as int) - 2) * 5 : 0 
        );
        
  void initializedBaseFareRate(double rate) => transactionBaseRate.value = rate;

  void initializedFareRate(double rate) => transactionRate.value = rate;

  void updateDistance(String distance) {
    transactionDistance.value = distance;
    retrieveFare();
  }

  //Additional fee for number of passenger
  double additionalFee() =>
      numberOfPassenger! > 2 ? (numberOfPassenger! - 2) * 5 : 0;

  double additionalFeePerRate() {
    var distance = transactionDistance.value.split(' ');

    if (distance[1] == 'km') {
      double distanceTemp = double.parse(distance[0]);

      //Subtract 1km on value distance
      distanceTemp -= 1;

      //difference of distance - 1km( minimum distance of base rate) multiply to additional rate fee for succeeding distance
      return distanceTemp * transactionRate.value;
    }

    //Return additional base on per km rate if less than 1km
    return 0;
  }

  String additionNameFee() => PriceClass().priceFormat(additionalFee());

  double get distanceTravel =>
      double.parse(transactionDistance.value.split(' ')[0].toString());

  String get numberOfPassengerOnBoard => (numberOfPassenger!).toString();

  //// [additionalFeePerRate] get additioal fare for succeding distance if exceed 1km( minimum base rate distance)
  //// [additionalFee] get additional fee for number of customer

  void retrieveFare() {
    double addFee = additionalFee();
    double total = transactionBaseRate.value + additionalFeePerRate() + addFee;
    transactionFare.value = total;
  }

  String retrieveTimeTravel() {
    DateTime from = startDate;
    DateTime to = DateTime.now();

    String travelTime = '';
    int minTravel = (to.difference(from).inMinutes).round();

    if (minTravel == 60) {
      int hour = to.difference(from).inHours;
      travelTime = '${hour.toString()} hr';
      return travelTime;
    }

    if (minTravel > 60) {
      int hour = to.difference(from).inHours;
      int min = minTravel - (hour * 60);
      travelTime = '${hour.toString()} hr ${min.toString()} mins';
      return travelTime;
    }

    travelTime = '${minTravel.toString()} ${minTravel == 1 ? "min" : "mins"}';
    return travelTime;
  }
}

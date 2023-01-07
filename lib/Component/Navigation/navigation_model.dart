import 'package:fair_calculator_driver/packages.dart';

class NavigationModel {
  LatLng? startLocation;
  LatLng? endLocation;
  String? distance;
  RxDouble additionFair = 25.0.obs;
  RxDouble fair = 0.0.obs;

  NavigationModel(LatLng start) {
    startLocation = start;
    endLocation = start;
  }
}

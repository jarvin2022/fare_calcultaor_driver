import 'package:fair_calculator_driver/packages.dart';

LatLng convertGeoPoint(GeoPoint p) => LatLng(p.latitude, p.longitude);

GeoPoint convertLatLngGeoPoint(LatLng l) => GeoPoint(l.latitude, l.longitude);

DateTime convertTs(Timestamp ts) => ts.toDate();

int convertToInt(String value) => int.parse(value);
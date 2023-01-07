import 'package:fair_calculator_driver/main.dart';
import 'package:fair_calculator_driver/packages.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';

class HomeController extends GetxController {
  GoogleMapController? googleMapController;
  final Completer<GoogleMapController> completer = Completer();

  final Rxn<Set<Polyline>> polylines = Rxn<Set<Polyline>>({}).obs();

  final RxList<TransactionModel> transactionStream = RxList<TransactionModel>().obs();
  final Rxn<TransactionModel>? transaction = Rxn<TransactionModel>(null).obs();

  final String googleApiKey = "AIzaSyCbS_RvBBvvV-Cp8yZ3vfZGDNfNaVenyMc";

  CameraPosition initialGooglePlex = const CameraPosition(
    target: LatLng(6.913584, 122.061091),
    zoom: 16.4746,
  );

  RxString exception = ''.obs;

  RxBool startJourney = false.obs;

  RxBool holdPolyline = false.obs;

  RxDouble baseFare = 0.0.obs;
  RxDouble rate = 0.0.obs;

  Rxn<LatLng> mypointLocation = Rxn<LatLng>().obs();

  Rxn<loc.Location> startingLocation = Rxn<loc.Location>(null).obs();

  Rxn<Directions?> dio = Rxn<Directions>(null).obs();
  // Rxn<Directions?> prevDio = Rxn<Directions>(null).obs();

  //Stream location of user
  Stream<loc.LocationData> myLocation = loc.Location().onLocationChanged;

  @override
  void onInit() {
    super.onInit(); transactionStream.bindStream(streamTransaction());
    myLocation.listen((loc) {
      if (holdPolyline.isTrue) {
        return;
      }
      if (transaction?.value == null) {
        mypointLocation.value = LatLng(loc.latitude!, loc.longitude!);

        return;
      }

      Timer(const Duration(milliseconds: 1000), () {
        updatePolyline(loc);

        try {
          transaction!.value!.transactionEndLocation =
              LatLng(loc.latitude!, loc.longitude!);
          transaction!.value!.transactionDuration.value =
              dio.value!.totalDuration!;
          transaction!.value!.transactionDistance.value =
              dio.value!.totalDistance!;
          List distanceList =
              transaction!.value!.transactionDistance.value.split(' ');

          if (distanceList[1] == 'km') {
            double distance = double.parse(distanceList[0]);
            transaction!.value!.transactionFare.value =
                distance * baseFare.value;
          } else {
            double distance = double.parse(distanceList[0]) / 1000;
            transaction!.value!.transactionFare.value =
                distance * baseFare.value;
          }
        } catch (e) {
          exception.value = e.toString();
        }
        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(loc.latitude!, loc.longitude!), zoom: 16)));
      });
    });
    dio.listen((p0) {
      if (p0 == null) {
        return;
      }
      mountPolyline();
    });
  }

  @override
  void onReady() {
    super.onReady();
    moveCameraToUser();
  }
  
  Stream<List<TransactionModel>> streamTransaction(){
    List<TransactionModel> list = [];

    Stream<QuerySnapshot> snapshot = firebaseFirestore.collection(transactionCollection).snapshots();

    snapshot.listen((event) { 
      if(event.docs.isNotEmpty){
        list.clear();
      }
    });


    return snapshot.map((event) {
        for (QueryDocumentSnapshot element in event.docs) {
            if(transaction?.value != null){
              transaction!.value!.status!.value = element.get('transaction_status');
              continue;
            }
            if(element.get('driver_id') == firebaseAuth.currentUser!.uid){
              transaction!.value = TransactionModel.fromJSON(element.data() as Map<String,dynamic>, element.id,mypointLocation.value!,mypointLocation.value!);
              transaction!.value!.initializedBaseFareRate(baseFare.value);
              transaction!.value!.initializedFareRate(rate.value);
              transaction!.value!.retrieveFare();
            }
        }

        return list.toList();
      }
    );
  }

  void moveCameraToUser() async {
    LatLng? myLocationPoint = await currentLocation();

    if (myLocationPoint != null) {
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: myLocationPoint, zoom: 16)));
    }
  }

  //// initialize new transaction
  /// initial start point and end point is current location
  /// distance as initial is 0 meter
  void startNavigation() {
    try {
      retrieveBaseFare();
      LatLng? startLocation = mypointLocation.value;

      if (startLocation != null) {
        transaction?.value = TransactionModel(
            transactionID: firebaseAuth.currentUser!.uid,
            transactionStartLocation: mypointLocation.value,
            transactionEndLocation: startLocation);
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void retrieveBaseFare() {
    try {
      UserController userController = Get.find<UserController>();
      baseFare.value =
          userController.fcontroller!.fare.value!.fareBaseRate.value;
      rate.value = userController.fcontroller!.fare.value!.fareRate.value;
    } catch (e) {
      exception.value = e.toString();
    }
  }

  Future<LatLng?> currentLocation() async {
    try {
      loc.LocationData locationData = await loc.Location().getLocation();

      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      exception.value = ' currentLocation module';
    }
    return null;
  }

  void updatePolyline(loc.LocationData loc) {
    try {
      buildPolyline(transaction!.value!.transactionStartLocation!,
          LatLng(loc.latitude!, loc.longitude!));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void updateTransaction() {
    transaction!.value!.transactionDuration.value = dio.value!.totalDuration!;
    transaction!.value!.transactionDistance.value = dio.value!.totalDistance!;
    double distance = double.parse(
        transaction!.value!.transactionDistance.value.split(' ')[0]);

    // transaction!.value!.transactionFare.value = distance * baseFare.value;
    transaction!.value!.transactionFare.value = 25;
  }

  void mountPolyline() {
    polylines.value!.add(Polyline(
      polylineId: const PolylineId('overview_polyline'),
      color: Colors.deepPurple,
      width: 5,
      points: dio.value!.polylinePoints!
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList(),
    ));
    polylines.refresh();
  }

  // If distance travel in 1 minute is less than 1 meter
  // then additional fee for fair will be added
  // for every 1 minute delay due to traffic fair will be added with value of 2 peso
  void checkForDistanceTravelInMinute() {}

  //build polyline for controller default polyline rx variable
  void buildPolyline(LatLng origin, LatLng destination) async =>
      dio.value = await createPolyline(origin, destination);

  Future<Directions?> createPolyline(LatLng origin, LatLng destination) async {
    return await DirectionsRepository()
        .getDirections(origin: origin, destination: destination);
  }

  void transactionComplete() async {
    holdPolyline.value = true;

    await firebaseFirestore.collection(historyCollection).add({
      'history_userID': firebaseAuth.currentUser!.uid,
      'history_distance': transaction!.value!.transactionDistance.value,
      'history_duration': transaction!.value!.transactionDuration.value,
      'history_fare': transaction!.value!.transactionFare.value,
      'history_start_point':
          convertLatLngGeoPoint(transaction!.value!.transactionStartLocation!),
      'history_end_point':
          convertLatLngGeoPoint(transaction!.value!.transactionEndLocation!),
    }).then((value) => resetTransaction());
  }

  void resetTransaction() {
    try {
      dio.value = null;
      transaction?.value = null;
      holdPolyline.value = false;
      Timer(const Duration(milliseconds: 300),
          () => Get.offAndToNamed(homeRoute));
    } catch (e) {
      exception.value = e.toString();
    }
  }
}

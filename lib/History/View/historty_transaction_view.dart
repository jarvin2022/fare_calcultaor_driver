import 'dart:async';

import 'package:fair_calculator_driver/packages.dart';

class HistoryTransactionView extends StatelessWidget {
  HistoryTransactionView({Key? key, this.historyModel}) : super(key: key);

  final HistoryModel? historyModel;

  final Completer<GoogleMapController> completer = Completer();

  final Rxn<Set<Polyline>> polylines = Rxn<Set<Polyline>>({}).obs();
  final Rxn<Directions?> dio = Rxn<Directions>(null).obs();
  final Rxn<GoogleMapController>? googleMapController =
      Rxn<GoogleMapController>(null).obs();

  @override
  Widget build(BuildContext context) {
    buildMap();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25.0, top: 5, right: 25.0, bottom: 5),
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        header(),
                        SizedBox(
                          width: Get.width,
                          height: 250,
                          child: transactionMapView(),
                        )
                      ],
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: transactionDetails(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void buildMap() async {
    dio.value = await createPolyline(
        historyModel!.historyStartPoint!, historyModel!.historyEndPoint!);
    mountPolyline();
    googleMapController!.refresh();
  }

  Future<Directions?> createPolyline(LatLng origin, LatLng destination) async {
    return await DirectionsRepository()
        .getDirections(origin: origin, destination: destination);
  }

  void mountPolyline() {
    polylines.value!.add(Polyline(
      polylineId: const PolylineId('overview_polyline'),
      color: const Color.fromARGB(255, 78, 169, 18),
      width: 5,
      points: dio.value!.polylinePoints!
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList(),
    ));
    polylines.refresh();
  }

  Widget transactionMapView() {
    CameraPosition initialGooglePlex = const CameraPosition(
      target: LatLng(6.913584, 122.061091),
      zoom: 16.4746,
    );

    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 1, spreadRadius: 1),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(color: Colors.white),
          child: Obx(
            () => dio.value != null
                ? GoogleMap(
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: initialGooglePlex,
                    polylines: polylines.value!,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    buildingsEnabled: false,
                    trafficEnabled: false,
                    onMapCreated: (GoogleMapController gmapController) {
                      completer.complete(gmapController);
                      googleMapController?.value = gmapController;
                      if (googleMapController?.value != null) {
                        Timer(
                            const Duration(milliseconds: 500),
                            () => googleMapController!.value!.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: historyModel!.historyEndPoint!,
                                    zoom: 16))));
                      }
                    },
                  )
                : const Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return SizedBox(
      width: 300,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 50,
              height: 50,
              child: Hero(
                  tag: historyModel?.historyID ?? '',
                  child: SvgPicture.asset('./assets/logo/Logo.svg'))),
          const SizedBox(width: 8),
          const Material(
            child: TextWidget(
              title: 'Fare Calculator',
              fontSized: 24,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 97, 88, 88),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionDetails() {
    return Column(children: [
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Date :',
            fontSized: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title:
                "${historyModel!.getDate()} ${historyModel!.getTimeStart()} ",
            fontSized: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Passenger:',
            fontSized: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title: historyModel!.historyNumberOfPassenger!.toString(),
            fontSized: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Distance Travel:',
            fontSized: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title: historyModel!.historyDistance!,
            fontSized: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Duration Travel:',
            fontSized: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title: historyModel!.historyDuration!,
            fontSized: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Additional Fee:',
            fontSized: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title: historyModel!.additionNameFee(),
            fontSized: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Base Rate:',
            fontSized: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title: PriceClass().priceFormat(historyModel!.historyFare!),
            fontSized: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 10),
      const Divider(
        color: Colors.green,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            title: 'Total Fare :',
            fontSized: 15,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(width: 10),
          TextWidget(
            title: PriceClass().priceFormat(historyModel!.historyFare!),
            fontSized: 20,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      const SizedBox(height: 60),
      SizedBox(
        width: Get.width,
        height: 40,
        child: MaterialButton(
          color: const Color.fromARGB(255, 78, 167, 18),
          onPressed: () {
            Get.back();
          },
          child: const TextWidget(
            title: 'Back',
            color: Colors.white,
            fontSized: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    ]);
  }
}
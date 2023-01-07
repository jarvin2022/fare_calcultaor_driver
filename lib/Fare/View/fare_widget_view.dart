import 'package:fair_calculator_driver/packages.dart';

class FareWidgetView extends GetView<FareController> {
  const FareWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: Get.width,
            height: 120,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 176, 18),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => TextWidget(
                          title:
                              'Base Rate: ${PriceClass().priceFormat(controller.fare.value?.fareBaseRate.value ?? 0)}',
                          fontSized: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextWidget(
                        title: DateFormatClass.getDateTime(
                                controller.fare.value?.fareDate ??
                                    DateTime.now())
                            .getTodayDateToString(),
                        fontSized: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 79, 88, 88),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 180,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: MaterialButton(
                      onPressed: () {
                        Get.toNamed(rateRoute);
                      },
                      child: const TextWidget(
                        title: 'Change base rate',
                        fontSized: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 79, 88, 88),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:fair_calculator_driver/packages.dart';

class TransactionView extends GetView<UserController> {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool status = false.obs;
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 176, 18),
        toolbarHeight: 0,
      ),
      body: SafeArea(
          child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: SvgPicture.asset(
                          './assets/logo/transaction_logo.svg'),
                    ),
                    const TextWidget(
                      title: 'TRANSACTION INFORMATION',
                      color: Color.fromARGB(255, 79, 88, 88),
                      fontSized: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                        width: Get.width,
                        height: Get.height * 0.3,
                        child: Obx(
                          () => status.isTrue
                              ? const Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(height: 50),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          title: 'Base Fare Rate:',
                                          fontSized: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(width: 10),
                                        Obx(
                                          () => TextWidget(
                                            title: PriceClass().priceFormat(
                                                controller.hcontroller!.baseFare
                                                    .value),
                                            fontSized: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          title: 'Distance Travel:',
                                          fontSized: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(width: 10),
                                        Obx(
                                          () => TextWidget(
                                            title: controller
                                                .hcontroller!
                                                .transaction!
                                                .value!
                                                .transactionDistance
                                                .value,
                                            fontSized: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          title: 'Duration Travel:',
                                          fontSized: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(width: 10),
                                        Obx(
                                          () => TextWidget(
                                            title: controller
                                                .hcontroller!
                                                .transaction!
                                                .value!
                                                .transactionDuration
                                                .value,
                                            fontSized: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(
                                      color: Colors.green,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          title: 'Total Fare :',
                                          fontSized: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(width: 10),
                                        Obx(
                                          () => TextWidget(
                                            title: PriceClass().priceFormat(
                                                controller
                                                    .hcontroller!
                                                    .transaction!
                                                    .value!
                                                    .transactionFare
                                                    .value),
                                            fontSized: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                        )),
                    SizedBox(height: Get.height * 0.17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: MaterialButton(
                              color: const Color.fromARGB(255, 79, 88, 88),
                              onPressed: () {
                                Get.back();
                                controller.hcontroller!.holdPolyline.value =
                                    false;
                              },
                              child: const TextWidget(
                                title: 'Back',
                                color: Colors.white,
                                fontSized: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: MaterialButton(
                              color: const Color.fromARGB(255, 76, 176, 18),
                              onPressed: () {
                                status.value = true;
                                controller.hcontroller!.transactionComplete();
                              },
                              child: const TextWidget(
                                title: 'Okay',
                                color: Color.fromARGB(255, 79, 88, 88),
                                fontSized: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}

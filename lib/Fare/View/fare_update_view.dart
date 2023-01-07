import 'package:fair_calculator_driver/packages.dart';

class FareUpdateView extends GetView<FareController> {
  const FareUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const TextWidget(
          title: 'Base Rate',
          color: Color.fromARGB(255, 79, 88, 88),
          fontSized: 16,
          fontWeight: FontWeight.w600,
        ),
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 78, 176, 18),
            )),
      ),
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset('./assets/logo/map_logo.svg')),
              const SizedBox(height: 10),
              SizedBox(
                width: Get.width * 0.8,
                child: const TextWidget(
                  textAlign: TextAlign.center,
                  title:
                      'Change base rate or fare rate per km, commuter must follow the standard rate of municifality if caught manipulating the fare rate will pay double the fare of the transaction ',
                ),
              ),
              const SizedBox(height: 40),
              TextFormWidget(
                prefixIcon: Icons.rate_review_rounded,
                controller: controller.rate,
                label: 'Fare base rate',
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Get.width,
                child: MaterialButton(
                  color: const Color.fromARGB(255, 78, 176, 18),
                  onPressed: () {
                    controller.updateBaseRate();
                  },
                  child: const TextWidget(
                    title: 'Save',
                    fontSized: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

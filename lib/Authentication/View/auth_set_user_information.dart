import 'package:fair_calculator_driver/packages.dart';

class AuthSetUserInformation extends GetView<UserController> {
  const AuthSetUserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 78, 176, 18),
      ),
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Positioned.fill(
                child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (_) => false,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      SizedBox(
                          width: 150,
                          height: 150,
                          child:
                              SvgPicture.asset('./assets/logo/user_bio.svg')),
                      const SizedBox(height: 25),
                      const TextWidget(
                        title: 'Set up account information',
                        fontSized: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 97, 88, 88),
                      ),
                      const SizedBox(height: 50),
                      form()
                    ],
                  ),
                ),
              ),
            )),
            Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  height: 70,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 120,
                            child: MaterialButton(
                              color: const Color.fromARGB(255, 78, 176, 18),
                              onPressed: () {
                                controller.registerInformation();
                              },
                              child: const TextWidget(
                                title: 'Submit',
                                fontSized: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 25),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.4,
        child: Column(
          children: [
            TextFormWidget(
              controller: controller.firstname,
              label: 'First name',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 25),
            TextFormWidget(
              controller: controller.lastname,
              label: 'Last name',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 25),
            TextFormWidget(
              controller: controller.address,
              label: 'Address',
              prefixIcon: Icons.house_rounded,
            ),
            const SizedBox(height: 25),
            TextFormWidget(
              controller: controller.plateNumber,
              label: 'Plate Number',
              prefixIcon: Icons.house_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

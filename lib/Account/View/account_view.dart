import 'package:fair_calculator_driver/packages.dart';

class AccountView extends GetView<UserController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.firstname.text = controller.user.value!.userFirstName!;
    controller.lastname.text = controller.user.value!.userLastName!;
    controller.address.text = controller.user.value!.userAddress!;
    controller.plateNumber.text = controller.user.value!.userPlateNumber!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextWidget(
          title: 'Account ',
          fontSized: 20,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 79, 88, 88),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1),
            ], borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 78, 176, 18),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      controller.clearText();
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: SingleChildScrollView(
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: SvgPicture.asset(
                                './assets/logo/account_logo.svg'),
                          ),
                          const SizedBox(height: 20),
                          TextFormWidget(
                            prefixIcon: Icons.person,
                            controller: controller.firstname,
                            label: 'First name',
                          ),
                          const SizedBox(height: 20),
                          TextFormWidget(
                            prefixIcon: Icons.person,
                            controller: controller.lastname,
                            label: 'Last name',
                          ),
                          const SizedBox(height: 20),
                          TextFormWidget(
                            prefixIcon: Icons.location_city_rounded,
                            controller: controller.address,
                            label: 'Address',
                          ),
                          const SizedBox(height: 20),
                          TextFormWidget(
                            prefixIcon: Icons.location_city_rounded,
                            controller: controller.plateNumber,
                            label: 'Plate Number',
                          ),
                          const SizedBox(height: 60),
                          MaterialButton(
                              minWidth: Get.width,
                              color: const Color.fromARGB(255, 78, 176, 18),
                              onPressed: () {
                                controller.requestPutUser();
                              },
                              child: const TextWidget(
                                title: 'Save',
                                color: Colors.white,
                                fontSized: 14,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      )),
                ),
              ),
            ),
            Positioned(child: success()),
            Positioned(child: warning()),
          ],
        ),
      )),
    );
  }

  Widget success() {
    return Obx(
      () => controller.success.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.success.value,
                      color: Colors.white,
                      fontSized: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.success.value = '';
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  Widget warning() {
    return Obx(
      () => controller.exception.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.exception.value,
                      color: Colors.white,
                      fontSized: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.exception.value = '';
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
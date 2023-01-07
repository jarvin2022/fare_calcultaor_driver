import 'dart:async';
import 'package:fair_calculator_driver/packages.dart';

class AuthRecoverAccount extends GetView<UserController> {
  const AuthRecoverAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 176, 18),
        toolbarHeight: 0,
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
                    height: Get.height * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          const TextWidget(
                            title: 'Account Recovery',
                            fontSized: 25,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 97, 88, 88),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: SvgPicture.asset(
                                './assets/logo/recover_logo.svg'),
                          ),
                          const SizedBox(height: 20),
                          TextWidget(
                            title:
                                'A account recovery link will be sent to your email',
                            fontSized: 12,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 40),
                          TextFormWidget(
                            controller: controller.email,
                            label: 'Email',
                            prefixIcon: Icons.email_rounded,
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: Get.width,
                            height: 40,
                            child: MaterialButton(
                              color: const Color.fromARGB(255, 78, 176, 18),
                              onPressed: () async {
                                bool status =
                                    await controller.sendEmailRecoveryLink();
                                if (status) {
                                  Timer(const Duration(seconds: 3),
                                      () => Get.back());
                                }
                              },
                              child: const TextWidget(
                                title: 'Sent recovery link',
                                fontSized: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: Get.width,
                            height: 40,
                            child: MaterialButton(
                              color: const Color.fromARGB(255, 97, 88, 88),
                              onPressed: () {
                                Get.back();
                              },
                              child: const TextWidget(
                                title: 'Back',
                                fontSized: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(top: 0, child: success()),
            Positioned(top: 0, child: exception()),
          ],
        ),
      )),
    );
  }

  Widget success() {
    return Obx(
      () => controller.authSuccess.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: const Color.fromARGB(255, 78, 176, 18),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.authSuccess.value,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.authSuccess.value = '';
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

  Widget exception() {
    return Obx(
      () => controller.authException.value != ''
          ? Container(
              width: Get.width,
              height: 50,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: controller.authException.value,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.authException.value = '';
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

import 'package:fair_calculator_driver/packages.dart';

class AuthSigninView extends GetView<UserController> {
  const AuthSigninView({Key? key}) : super(key: key);

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
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      header(),
                      SizedBox(height: Get.height * 0.07),
                      form(),
                    ],
                  ),
                ),
              ),
            )),
            Positioned(top: 0, child: exception())
          ],
        ),
      )),
    );
  }

  Widget header() {
    return Hero(
      tag: 'header',
      child: SizedBox(
        width: 300,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: SvgPicture.asset('./assets/logo/Logo.svg')),
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
      ),
    );
  }

  Widget form() {
    return SizedBox(
      width: Get.width,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            TextFormWidget(
              controller: controller.email,
              label: 'Email',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),
            TextFormWidget(
              controller: controller.password,
              label: 'Password',
              prefixIcon: Icons.lock,
              obscureState: controller.obscureStatus,
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Get.toNamed(recoverRoute);
                },
                child: TextWidget(
                  title: 'forgot password?',
                  color: Colors.grey.shade600,
                  fontSized: 14,
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 40,
              child: MaterialButton(
                color: const Color.fromARGB(255, 78, 176, 18),
                onPressed: () {
                  controller.siginIn();
                },
                child: const TextWidget(
                  title: 'Signin',
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
                  Get.toNamed(signupRoute);
                },
                child: const TextWidget(
                  title: 'Sign up',
                  fontSized: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
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

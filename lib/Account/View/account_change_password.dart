import 'package:fair_calculator_driver/packages.dart';

class AccountChangePasswordView extends StatelessWidget {
  const AccountChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 176, 18),
        title: const TextWidget(
          title: 'Update Password ',
          fontSized: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        leading: IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 79, 88, 88),
            )),
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset('./assets/logo/password_logo.svg'),
                  ),
                ],
              ))),
    );
  }
}

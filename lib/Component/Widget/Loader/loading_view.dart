import 'package:fair_calculator_driver/packages.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: const Center(
            child: SizedBox(
              width: 300,
              height: 180,
              child: Image(
                image: AssetImage('./assets/logo/splash-screen-logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:fair_calculator_driver/packages.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset('./assets/logo/about_logo.svg'),
                  ),
                  const TextWidget(
                    title: 'About us',
                    fontSized: 26,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 79, 88, 88),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: const TextWidget(
                      title:
                          'Fare calculator is an app which its mission is to help commuters in their daily basis of travel using tricycle '
                          'by using the app it will stand as a monitoring of distance travel and compute for the exact amount of payment.'
                          '\n\nThe commuter need to input the fare rate per km in the app, note that commuters also must follow the municifality rate.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 70),
                  const Divider(
                    indent: 40,
                    endIndent: 40,
                  ),
                  const TextWidget(
                    title: 'DEVELOPERS',
                    color: Color.fromARGB(255, 79, 88, 88),
                    fontSized: 16,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 5,
                  ),
                  const Divider(
                    indent: 40,
                    endIndent: 40,
                  ),
                  const SizedBox(height: 15),
                  const TextWidget(
                    title: 'Jarvin Darel S. Yazon',
                    color: Color.fromARGB(255, 79, 88, 88),
                    fontSized: 12,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 5,
                  ),
                  const SizedBox(height: 5),
                  const TextWidget(
                    title: 'Kevin Clark B. Cuevas',
                    color: Color.fromARGB(255, 79, 88, 88),
                    fontSized: 12,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 5,
                  ),
                  const SizedBox(height: 5),
                  const TextWidget(
                    title: 'Asiya A. Lingkatan',
                    color: Color.fromARGB(255, 79, 88, 88),
                    fontSized: 12,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 5,
                  ),
                ],
              ))),
    );
  }
}
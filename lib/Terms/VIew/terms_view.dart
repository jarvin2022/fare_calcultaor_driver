import 'package:fair_calculator_driver/packages.dart';

class TermsView extends StatelessWidget {
  const TermsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        elevation: 0,
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
                    child: SvgPicture.asset('./assets/logo/terms_logo.svg'),
                  ),
                  const TextWidget(
                    title: 'Terms and Condition',
                    fontSized: 26,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 79, 88, 88),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: const TextWidget(
                      title:
                          'By creating an account you agree with the terms and condition of fare calculator. '
                          'transaction will be save as your history transaction and lost of data will not be fault of the fare calculator developer.'
                          '\n\nYour email and data will be collected and only be accessible by you, no other person will be able to '
                          'view your data that is why in fare calculator your data is safe.',
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
                    title: 'Yason Jarvin',
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
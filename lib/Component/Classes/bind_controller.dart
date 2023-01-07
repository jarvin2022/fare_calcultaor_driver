import 'package:fair_calculator_driver/Home/Controller/home_controller.dart';
import 'package:fair_calculator_driver/packages.dart';

class BindController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<FareController>(() => FareController());
  }
}

import 'package:get/get.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CryptoController());
  }
}

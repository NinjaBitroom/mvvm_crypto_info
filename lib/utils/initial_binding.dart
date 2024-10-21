import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NumberFormat());
    Get.put(
      Dio(
        BaseOptions(
          baseUrl: 'https://api.coingecko.com/api/v3',
          queryParameters: {'vs_currency': 'brl'},
        ),
      ),
    );
    Get.put(CryptoController());
  }
}

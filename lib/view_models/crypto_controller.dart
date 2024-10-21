import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_crypto_info/models/crypto_model.dart';

class CryptoController extends GetxController
    with StateMixin<List<CryptoModel>> {
  final _dio = Get.find<Dio>();

  @override
  Future<void> onInit() async {
    await fetchCryptos();
    super.onInit();
  }

  Future<void> fetchCryptos() async {
    try {
      change(null, status: RxStatus.loading());
      final response = await _dio.get<List<dynamic>>(
        '/coins/markets',
        queryParameters: {
          'order': 'market_cap_desc',
          'per_page': 20,
          'page': 1,
        },
      );
      if (response.statusCode == 200) {
        final jsonData = response.data;
        final loadedCryptos = jsonData?.map((cryptoJson) {
          return CryptoModel.fromJson(cryptoJson);
        }).toList();
        change(loadedCryptos, status: RxStatus.success());
      }
    } catch (e, s) {
      debugPrint('Erro ao buscar criptomoedas: $e');
      debugPrint('Stacktrace: $s');
      change(
        null,
        status: RxStatus.error(e.toString()),
      );
    }
  }

  Future<void> fetchCryptoChart(int index) async {
    final crypto = state?[index];
    change(state, status: RxStatus.loading());
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/coins/${crypto?.id}/market_chart',
        queryParameters: {
          'days': 30,
          'interval': 'daily',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = response.data;
        crypto?.priceHistory = jsonData?['prices'];
        change(state, status: RxStatus.success());
      }
    } catch (e, s) {
      debugPrint('Erro ao buscar histórico de preços: $e');
      debugPrint('Stacktrace: $s');
      change(
        state,
        status: RxStatus.error(e.toString()),
      );
    }
  }
}

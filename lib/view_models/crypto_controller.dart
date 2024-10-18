import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_crypto_info/models/crypto_model.dart';

class CryptoController extends GetxController {
  final isLoading = false.obs;
  final cryptos = <CryptoModel>[].obs;
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.coingecko.com/api/v3',
    queryParameters: {'vs_currency': 'brl'},
  ));

  @override
  void onInit() {
    fetchCryptos();
    super.onInit();
  }

  void fetchCryptos() async {
    bool error = false;
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 4));
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
        final loadedCryptos = await jsonData?.map((cryptoJson) async {
          await Future.delayed(const Duration(seconds: 6));
          final newResponse = await _dio.get<Map<String, List<dynamic>>>(
            '/coins/${cryptoJson['id']}/market_chart',
            queryParameters: {
              'days': 30,
              'interval': 'daily',
            },
          );
          cryptoJson['price_history'] = newResponse.data?['prices'];
          return CryptoModel.fromJson(cryptoJson);
        }).wait;
        cryptos.value = loadedCryptos!;
      }
    } catch (e, s) {
      debugPrint('Erro ao buscar criptomoedas: $e');
      debugPrint('Stacktrace: $s');
      debugPrint('Por favor, tente novamente em 1 minuto.');
      error = true;
    } finally {
      isLoading(false);
      if (error) {
        await Future.delayed(const Duration(minutes: 1));
        debugPrint('Reinicie o app...');
      }
    }
  }
}

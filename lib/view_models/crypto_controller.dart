import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_crypto_info/models/crypto_model.dart';

class CryptoController extends GetxController {
  final isLoading = false.obs;
  final cryptos = <CryptoModel>[].obs;
  final _dio = Dio();

  @override
  void onInit() {
    fetchCryptos();
    super.onInit();
  }

  void fetchCryptos() async {
    try {
      isLoading(true);
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'brl',
          'order': 'market_cap_desc',
          'per_page': 20,
          'page': 1,
          'sparkline': false,
        },
      );
      if (response.statusCode == 200) {
        final jsonData = response.data as List;
        final loadedCryptos = jsonData.map((cryptoJson) {
          final newResponse = _dio.get(
            'https://api.coingecko.com/api/v3/coins/${cryptoJson['id']}/market_chart',
            queryParameters: {
              'vs_currency': 'brl',
              'days': 7,
              'interval': 'daily',
            },
          );
          cryptoJson['price_history'] = [
            FlSpot(0, 30000), // Exemplo de preços
            FlSpot(1, 31000),
            FlSpot(2, 29000),
            FlSpot(3, 32000),
            FlSpot(4, 33000),
          ];
          return CryptoModel.fromJson(cryptoJson);
        }).toList();
        cryptos.value = loadedCryptos;
      }
    } catch (e) {
      debugPrint('Erro ao buscar criptomoedas: $e');
    } finally {
      isLoading(false);
    }
  }
}

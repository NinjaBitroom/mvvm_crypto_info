import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';

class CryptoDetailPage extends StatelessWidget {
  final int index;

  CryptoDetailPage({super.key, required this.index});

  final cryptoController = Get.find<CryptoController>();

  @override
  Widget build(BuildContext context) {
    final crypto = cryptoController.cryptos[index];
    final currency = NumberFormat.simpleCurrency();
    return Scaffold(
      appBar: AppBar(
        title: Text(crypto.cryptoName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(crypto.image),
                    Text(
                      crypto.symbol,
                      style: context.textTheme.displayLarge,
                    ),
                    Text(
                      'Preço: ${currency.format(crypto.price)}',
                      style: context.textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
            Card.filled(
              child: ListTile(
                title: Text(crypto.description),
                titleTextStyle: context.textTheme.titleLarge,
                subtitleTextStyle: context.textTheme.bodyMedium,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Volume total: ${currency.format(crypto.volume)}'),
                    Text(
                      'Capitalização de Mercado: ${currency.format(crypto.marketCap)}',
                    ),
                  ],
                ),
              ),
            ),
            Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: crypto.priceHistory,
                        isCurved: true,
                        color: context.theme.primaryColor,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

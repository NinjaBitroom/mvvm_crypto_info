import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';

class CryptoDetailPage extends GetView<CryptoController> {
  final int index;

  const CryptoDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final currency = Get.find<NumberFormat>();
    return controller.obx(
      (state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state![index].cryptoName),
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
                        Image.network(state[index].image),
                        Text(
                          state[index].symbol,
                          style: context.textTheme.displayLarge,
                        ),
                        Text(
                          'Preço: ${currency.format(state[index].price)}',
                          style: context.textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Card.filled(
                  child: ListTile(
                    title: Text(state[index].id),
                    titleTextStyle: context.textTheme.titleLarge,
                    subtitleTextStyle: context.textTheme.bodyMedium,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Volume total: ${currency.format(state[index].volume)}',
                        ),
                        Text(
                          'Capitalização de Mercado: ${currency.format(state[index].marketCap)}',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Card.filled(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChart(
                        LineChartData(
                          backgroundColor:
                              context.theme.colorScheme.surfaceContainer,
                          lineBarsData: [
                            LineChartBarData(
                              spots: state[index]
                                  .priceHistory!
                                  .map(
                                    (e) => FlSpot(
                                      e[0].toDouble(),
                                      e[1].toDouble(),
                                    ),
                                  )
                                  .toList(),
                              color: context.theme.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onLoading: Scaffold(
        appBar: AppBar(
          title: Text(controller.state![index].cryptoName),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

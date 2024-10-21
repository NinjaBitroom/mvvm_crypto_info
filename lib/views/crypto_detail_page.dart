import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';

class CryptoDetailPage extends GetView<CryptoController> {
  final int index;

  const CryptoDetailPage({super.key, required this.index});

  String formatNumber(double value) {
    if (value >= 1000 && value < 1000000) {
      return 'R\$ ${(value / 1000).toStringAsFixed(0)}K';
    } else if (value >= 1000000 && value < 1000000000) {
      return 'R\$ ${(value / 1000000).toStringAsFixed(0)}M';
    } else if (value >= 1000000000) {
      return 'R\$ ${(value / 1000000000).toStringAsFixed(0)}B';
    } else {
      return 'R\$ $value';
    }
  }

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
                          'Preço: R\$ ${currency.format(state[index].price)}',
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
                          'Volume total: R\$ ${currency.format(state[index].volume)}',
                        ),
                        Text(
                          'Capitalização de Mercado: R\$ ${currency.format(state[index].marketCap)}',
                        ),
                      ],
                    ),
                  ),
                ),
                Card.filled(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: context.mediaQuerySize.height * 0.3,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (touchedSpot) =>
                                  context.theme.colorScheme.tertiaryContainer,
                              getTooltipItems: (touchedSpots) => touchedSpots
                                  .map(
                                    (touchedSpot) => LineTooltipItem(
                                      'R\$ ${currency.format(touchedSpot.y)}',
                                      context.textTheme.titleMedium ??
                                          const TextStyle(),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          backgroundColor:
                              context.theme.colorScheme.secondaryContainer,
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
                              color: context
                                  .theme.colorScheme.onSecondaryContainer,
                            ),
                          ],
                          titlesData: FlTitlesData(
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                minIncluded: false,
                                maxIncluded: false,
                                reservedSize:
                                    context.mediaQuerySize.width * 0.175,
                                getTitlesWidget: (value, meta) =>
                                    Text(formatNumber(value)),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                maxIncluded: false,
                                minIncluded: false,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final date =
                                      DateTime.fromMillisecondsSinceEpoch(
                                    value.toInt(),
                                  );
                                  final formattedDate = DateFormat(
                                    'dd/MM',
                                  ).format(date);
                                  return Text(formattedDate);
                                },
                              ),
                            ),
                          ),
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

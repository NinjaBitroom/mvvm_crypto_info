import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';
import 'package:mvvm_crypto_info/views/crypto_detail_page.dart';

class CryptoListPage extends GetView<CryptoController> {
  const CryptoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preços de Criptomoedas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchCryptos,
          ),
        ],
      ),
      body: controller.obx((state) {
        return ListView.builder(
          itemCount: state?.length,
          itemBuilder: (context, index) {
            var crypto = state?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Cor da sombra
                      spreadRadius: 2, // Espalhamento da sombra
                      blurRadius: 8, // Borrão da sombra
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.80,
                height: 70,
                child: ListTile(
                  onTap: () {
                    controller.fetchCryptoChart(index);
                    Get.to(() => CryptoDetailPage(index: index));
                  },
                  leading: Image.network(
                    crypto!.image,
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    crypto.cryptoName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    crypto.symbol.toUpperCase(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    NumberFormat.simpleCurrency().format(crypto.price),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

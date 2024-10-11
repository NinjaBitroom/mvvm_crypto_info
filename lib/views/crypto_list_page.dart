import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';
import 'package:mvvm_crypto_info/views/crypto_detail_page.dart';

class CryptoListPage extends StatelessWidget {
  CryptoListPage({super.key});

  final cryptoController = Get.find<CryptoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preços de Criptomoedas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: cryptoController.fetchCryptos,
          ),
        ],
      ),
      body: Obx(() {
        if (cryptoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (cryptoController.cryptos.isEmpty) {
          return const Center(child: Text('Nenhuma criptomoeda encontrada.'));
        } else {
          return ListView.builder(
            itemCount: cryptoController.cryptos.length,
            itemBuilder: (context, index) {
              var crypto = cryptoController.cryptos[index];
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
                      Get.to(() => CryptoDetailPage(index: index));
                    },
                    leading: Image.network(
                      crypto.image,
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
        }
      }),
    );
  }
}

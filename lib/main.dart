import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/utils/custom_theme.dart';
import 'package:mvvm_crypto_info/view_models/crypto_controller.dart';
import 'package:mvvm_crypto_info/views/crypto_list_page.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  Get.put(CryptoController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: CryptoListPage(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_crypto_info/utils/custom_theme.dart';
import 'package:mvvm_crypto_info/utils/initial_binding.dart';
import 'package:mvvm_crypto_info/views/crypto_list_page.dart';

class App extends GetWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.createThemeDataFromBrightness(Brightness.light),
      darkTheme: CustomTheme.createThemeDataFromBrightness(Brightness.dark),
      home: const CryptoListPage(),
    );
  }
}

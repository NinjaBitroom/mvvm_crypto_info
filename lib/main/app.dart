import 'package:get/get.dart';
import 'package:mvvm_crypto_info/utils/custom_theme.dart';
import 'package:mvvm_crypto_info/utils/initial_binding.dart';
import 'package:mvvm_crypto_info/views/crypto_list_page.dart';

final app = GetMaterialApp(
  initialBinding: InitialBinding(),
  debugShowCheckedModeBanner: false,
  theme: customTheme,
  home: CryptoListPage(),
);

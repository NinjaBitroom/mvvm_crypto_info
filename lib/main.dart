import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_crypto_info/main/app.dart';

Future<void> main() async {
  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting('pt_BR', null);
  runApp(const App());
}

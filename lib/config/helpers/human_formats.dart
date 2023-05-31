import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadbleNumber(double number) {
    // * NumberFormat pertence a la libreria intl que es una dependencia que instalamos con Pubspec Assist
    final formatterNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
            .format(number);

    return formatterNumber;
  }
}

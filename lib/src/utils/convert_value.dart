import 'package:intl/intl.dart';

const PATTERN_1 = 'dd/MM/yy HH:mm';
const PATTERN_2 = 'dd/MM/yyyy';
const PATTERN_3 = 'HH:mm a';
const PATTERN_4 = 'HH:mm dd/MM/yy';
const PATTERN_5 = 'HH:mm';

// String convertDateToString(DateTime date, {String pattern = PATTERN_2}) {
//   return DateFormat(pattern).format(date);
// }
// /// convert qua view tiền VN với pattern dấu chấm(.)
// String convertMoneytoStringDot(num value) {
//   final currencyFormatter =
//   NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: 'đ');
//   return currencyFormatter.format(value);
// }
//
// /// format tiền VN với pattern dấu phẩy(,)
// String convertMoneytoStringComma(num value) {
//   String price = value.toInt().toString();
//   if (price.length > 2) {
//     price = price.replaceAll(RegExp(r'\D'), '');
//     price = price.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
//     return price;
//   } else {
//     return price;
//   }
// }
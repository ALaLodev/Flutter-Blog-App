import 'package:intl/intl.dart';

String formatDateBydMMMYYYY(DateTime dateTime) {
  // Convierte la fecha a formato: "12 Feb, 2024"
  return DateFormat("d MMM, yyyy").format(dateTime);
}

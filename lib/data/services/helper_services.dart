import 'dart:ui';

class Helpers {
  static String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = (hour < 12) ? 'AM' : 'PM';

    // Convert to 12-hour format
    hour = hour % 12;
    hour = (hour != 0) ? hour : 12;

    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';
    return formattedTime;
  }
}

Color hexToColor(String hexString) {
  // Remove the '#' if it exists
  final buffer = StringBuffer();
  if (hexString.startsWith('#')) {
    hexString = hexString.substring(1);
  }
  // Add 'FF' for full opacity if not provided
  if (hexString.length == 6) {
    buffer.write('FF');
  }
  buffer.write(hexString);
  return Color(int.parse(buffer.toString(), radix: 16));
}

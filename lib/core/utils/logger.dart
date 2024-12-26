import 'dart:developer' as consol;

class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void log(String message, String error) {
    if (_logMode == LogMode.debug) {
      consol.log(message, error: error);
    }
  }
}

enum LogMode { debug, live }

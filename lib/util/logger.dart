import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class MLogger {
  MLogger._();


  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  static void debug(String message) {
    if (kDebugMode) {
      _logger.d(message);
    }
  }
}
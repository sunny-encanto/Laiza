import 'package:flutter/material.dart';
import 'package:laiza/core/app_export.dart';

import '../../localization/app_localization.dart';

extension SnackBarExtension on BuildContext {
  ScaffoldFeatureController showSnackBar(String message) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    return ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(duration: const Duration(seconds: 1), content: Text(message)));
  }
}

extension LocalizationExtension on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}

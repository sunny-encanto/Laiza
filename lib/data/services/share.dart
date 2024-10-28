import 'dart:developer';

import 'package:share_plus/share_plus.dart';

Future<void> shareContent(String subject) async {
  try {
    await Share.share(subject);
  } catch (e) {
    log('Error During Share', error: e);
  }
}

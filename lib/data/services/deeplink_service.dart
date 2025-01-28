import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../../core/app_export.dart';
import '../../main.dart';

class DeepLinkService {
  static StreamSubscription? dynamicLinkSubscription;

  /// Initialize and handle dynamic links
  static Future<void> handleDynamicLinks() async {
    // Handle dynamic links when the app is terminated and launched via a link
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;

      if (PrefUtils.getId().isNotEmpty) {
        _navigateToPage(uri: deepLink, isFromTerminate: true);
      }
    }

    // Handle dynamic links when the app is already running in the background or foreground
    dynamicLinkSubscription =
        FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      if (PrefUtils.getId().isNotEmpty) {
        _navigateToPage(uri: deepLink, isFromTerminate: false);
      }
    });
  }

  /// Navigate to the appropriate page based on the dynamic link URI
  static void _navigateToPage(
      {required Uri uri, required bool isFromTerminate}) {
    print("Dynamic Link URL: $uri");
    final id = uri.queryParameters['id']; // Extract the 'id' parameter
    print("Extracted ID: $id");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (uri.path == '/profile' && id != null) {
        navigatorKey.currentState?.pushNamed(AppRoutes.influencerProfileScreen,
            arguments: id.toString());
      }
    });
  }

  /// Dispose the dynamic link subscription when it's no longer needed
  static void dispose() {
    dynamicLinkSubscription?.cancel();
  }
}

// import 'dart:async';
//
// import 'package:laiza/core/utils/pref_utils.dart';
// import 'package:uni_links/uni_links.dart';
//
// import '../../core/app_export.dart';
// import '../../main.dart';
//
// class DeepLinkService {
//   static StreamSubscription<Uri?>? linkSubscription;
//
//   static Future<void> handleIncomingLinks() async {
//     // Handle initial link (for when the app is launched from a deep link)
//     final Uri? initialLink = await getInitialUri();
//     if (initialLink != null) {
//       if (PrefUtils.getId().isNotEmpty) {
//         _navigateToPage(uri: initialLink, isFromTerminate: true);
//       }
//       // Navigate immediately if there is an initial link
//     }
//
//     // Listen for new incoming links (for when the app is already running)
//     linkSubscription = uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         if (PrefUtils.getId().isNotEmpty) {
//           _navigateToPage(uri: uri, isFromTerminate: false);
//         }
//       }
//     }, onError: (err) {
//       print('Failed to handle deep link: $err');
//     });
//   }
//
//   static void _navigateToPage(
//       {required Uri uri, required bool isFromTerminate}) {
//     print("Url:$uri");
//     final id = uri.queryParameters['id']; // Extract the 'id' parameter
//     print("Extracted ID: $id");
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (uri.path == '/profile' && id != null) {
//         navigatorKey.currentState?.pushNamed(AppRoutes.influencerProfileScreen,
//             arguments: id.toString());
//       }
//     });
//   }
// }

import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../../../core/app_export.dart';
import '../../../data/services/firebase_services.dart';

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({super.key, required this.liveID, required this.isHost});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: ApiConstant.appID,
        appSign: ApiConstant.appSign,
        userID: PrefUtils.getId(),
        userName: PrefUtils.getUserName(),
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
          ..preview.showPreviewForHost = false,
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          onEnded: (
            ZegoLiveStreamingEndEvent event,
            VoidCallback defaultAction,
          ) async {
            if (ZegoLiveStreamingEndReason.hostEnd == event.reason) {
              if (event.isFromMinimizing) {
                ZegoUIKitPrebuiltLiveStreamingController().minimize.hide();
              } else {
                Navigator.pop(context);
              }
            } else {
              defaultAction.call();
            }
            if (isHost) {
              await FirebaseServices.deleteOnGoingStream(liveID);
            } else {
              await FirebaseServices.updateOnGoingLiveStream(
                  id: liveID, isAdd: false);
            }
          },
        ),
      ),
    );
  }
}

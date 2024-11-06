import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../../../core/app_export.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/services/firebase_services.dart';

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({
    super.key,
    required this.liveID,
    required this.isHost,
  });

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
          ..avatarBuilder = (BuildContext context, Size size,
              ZegoUIKitUser? user, Map extraInfo) {
            return user != null ? _buildProfile(user.id) : const SizedBox();
          }
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

  _buildProfile(String userId) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseServices.getUserById(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          UserModel user = UserModel.fromJson(
              json: snapshot.data?.data() as Map<String, dynamic>,
              id: snapshot.data?.id ?? "");
          return CustomImageView(
            radius: BorderRadius.circular(30.h),
            fit: BoxFit.fill,
            imagePath: user.profile.toString().isNotEmpty
                ? user.profile
                : ImageConstant.defaultProfile,
          );
        });
  }
}

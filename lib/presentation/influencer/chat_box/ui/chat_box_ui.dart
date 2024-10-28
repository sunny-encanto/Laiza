import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/services/firebase_services.dart';
import 'package:laiza/presentation/influencer/chat_box/ui/media_message_widget/media_message_widget.dart';
import 'package:laiza/presentation/influencer/chat_box/ui/video_message_widget.dart/video_message.dart';

import '../../../../data/services/notification_service.dart';

class ChatBoxScreen extends StatelessWidget {
  final String id;
  ChatBoxScreen({super.key, required this.id});
  final _messageController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _buildAppBar(textTheme),
      body: SingleChildScrollView(
        controller: listScrollController,
        reverse: true,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseServices.getChats(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              }
              var data = snapshot.data?.docs ?? [];
              List<Message> messages = <Message>[];
              messages.clear();
              messages = data
                  .map((e) => Message.fromJson(
                      json: e.data() as Map<String, dynamic>, id: e.id))
                  .toList();
              return Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(
                        messages.length,
                        (index) {
                          if (messages[index].receiverId == PrefUtils.getId() &&
                              messages[index].isSeen == false) {
                            try {
                              FirebaseServices.updateChat(
                                  senderId: messages[index].senderId!,
                                  docId: messages[index].dcoId);
                            } catch (e) {
                              debugPrint('isSeen Error $e');
                            }
                          }
                          return _getMessageWidget(messages[index], textTheme);
                          // messages[index].senderId != PrefUtils.getId()
                          //     ? _buildLeftBubble(messages[index], textTheme)
                          //     : _buildRightBubble(messages[index], textTheme);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 70.v,
                    ),
                  ],
                ),
              );
            }),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10.h),
        child: CustomTextFormField(
          controller: _messageController,
          hintText: 'Enter Message',
          prefix: IconButton(
            onPressed: () async {
              await FirebaseServices.sendMediaChat(id);
            },
            icon: Icon(
              Icons.add,
              color: AppColor.primary,
            ),
          ),
          suffix: IconButton(
            onPressed: () async {
              if (_messageController.text.isNotEmpty) {
                Message message = Message(
                  roomId: FirebaseServices.createChatRoomId(id),
                  receiverId: id,
                  senderId: PrefUtils.getId(),
                  message: _messageController.text,
                  type: MessageType.Text.name,
                  timestamp: DateTime.now().toString(),
                );
                await FirebaseServices.sendMessage(message: message);
                scrollDown();
                // Push Notification
                FirebaseServices.sendChatNotification(
                    type: NotificationType.Chat.name,
                    id: id,
                    message: _messageController.text.trim());
                _messageController.clear();
              } else {
                Fluttertoast.showToast(msg: "Empty message Can't send");
              }
            },
            icon: Icon(
              Icons.send,
              color: AppColor.primary,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(TextTheme textTheme) {
    return PreferredSize(
        preferredSize: Size(SizeUtils.width, 66.v),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseServices.getUserById(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              }
              UserModel user = UserModel.fromJson(
                  json: snapshot.data?.data() as Map<String, dynamic>,
                  id: snapshot.data?.id ?? "");
              return AppBar(
                leadingWidth: 30.h,
                toolbarHeight: 66.v,
                centerTitle: false,
                title: Row(
                  children: [
                    CustomImageView(
                      height: 50.h,
                      width: 50.h,
                      radius: BorderRadius.circular(50.h),
                      fit: BoxFit.fill,
                      imagePath: user.profile,
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      user.name ?? "",
                      style: textTheme.titleMedium,
                    )
                  ],
                ),
              );
            }));
  }

  _buildChatProfile(String userId) {
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
            height: 30.h,
            width: 30.h,
            radius: BorderRadius.circular(30.h),
            fit: BoxFit.fill,
            imagePath: user.profile.toString().isNotEmpty
                ? user.profile
                : ImageConstant.defaultProfile,
          );
        });
  }

  Padding _buildLeftBubble(Message message, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildChatProfile(message.senderId ?? ''),
              SizedBox(width: 5.h),
              Container(
                constraints: BoxConstraints(maxWidth: SizeUtils.width - 100.h),
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(46.h),
                      bottomRight: Radius.circular(46.h),
                      topRight: Radius.circular(46.h),
                    )),
                child: Text(
                  message.message ?? "",
                  style:
                      textTheme.titleSmall!.copyWith(color: AppColor.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
              DateFormat('hh:mm a')
                  .format(DateTime.parse(message.timestamp ?? '')),
              style: textTheme.bodySmall),
        ],
      ),
    );
  }

  Padding _buildRightBubble(Message message, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: SizeUtils.width - 100.h),
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(46.h),
                      bottomLeft: Radius.circular(46.h),
                      topRight: Radius.circular(46.h),
                    )),
                child: Text(
                  message.message ?? "",
                  style: textTheme.titleSmall,
                ),
              ),
              SizedBox(width: 5.h),
              _buildChatProfile(message.senderId ?? ''),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  DateFormat('hh:mm a')
                      .format(DateTime.parse(message.timestamp ?? '')),
                  style: textTheme.bodySmall),
              SizedBox(width: 5.h),
              Container(
                decoration: message.isSeen ?? false
                    ? BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.primary)
                    : null,
                child: Icon(
                  Icons.done,
                  size: 12.h,
                  color: message.isSeen ?? false ? Colors.white : Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  scrollDown() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.minScrollExtent;
      listScrollController.jumpTo(position);
    }
  }

  Widget _getMessageWidget(Message message, TextTheme textTheme) {
    switch (message.type) {
      case 'Text':
        return message.senderId != PrefUtils.getId()
            ? _buildLeftBubble(message, textTheme)
            : _buildRightBubble(message, textTheme);
      case 'Media':
        return MediaMessageWidget(message: message);
      case 'Video':
        return VideoMessageWidget(message: message);
      default:
        return Text('No Widget Found ${message.type}');
    }
  }
}

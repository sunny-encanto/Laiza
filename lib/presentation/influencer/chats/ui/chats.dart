import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/services/firebase_services.dart';

import '../../../../core/app_export.dart';
import '../../../empty_pages/no_chats_found/no_chats_found.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final _searchController = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Chats',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        )),
        body: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              CustomTextFormField(
                controller: _searchController,
                prefixConstraints: BoxConstraints(maxWidth: 25.h),
                prefix: Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: CustomImageView(
                    width: 15.h,
                    imagePath: ImageConstant.searchIcon,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    query = val;
                  });
                },
                hintText: 'Search',
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getAllChats(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var dataList = snapshot.data?.docs ?? [];
                    List userList = [];
                    userList.clear();
                    for (var doc in dataList) {
                      if (doc.id.contains(PrefUtils.getId())) {
                        List userIds = doc.id.split('_');
                        userIds.remove(PrefUtils.getId());
                        userList.addAll(userIds);
                      }
                    }
                    return Expanded(
                      child: userList.isEmpty
                          ? const NoChatsFoundScreen()
                          : ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(height: 2.v),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: userList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => StreamBuilder<
                                      DocumentSnapshot>(
                                  stream: FirebaseServices.getUserById(
                                      userList[index]),
                                  builder: (context, userSnapshot) {
                                    if (userSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox.shrink();
                                    }
                                    UserModel user = UserModel.fromJson(
                                        json: userSnapshot.data?.data()
                                            as Map<String, dynamic>,
                                        id: userSnapshot.data?.id ?? '');
                                    return StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseServices.getLastChats(
                                            userList[index]),
                                        builder: (context, chatSnapshot) {
                                          if (chatSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const SizedBox.shrink();
                                          }
                                          var data =
                                              chatSnapshot.data?.docs ?? [];
                                          List<Message> messages = <Message>[];
                                          messages.clear();
                                          messages = data
                                              .map((e) => Message.fromJson(
                                                  json: e.data()
                                                      as Map<String, dynamic>,
                                                  id: e.id))
                                              .toList();
                                          return Visibility(
                                            visible: isVisible(user.name ?? ""),
                                            child: _buildUserItem(
                                                user,
                                                getLastMessage(messages),
                                                getUnSeenMessageCount(
                                                            messages) ==
                                                        0
                                                    ? ''
                                                    : getUnSeenMessageCount(
                                                            messages)
                                                        .toString(),
                                                context),
                                          );
                                        });
                                  }),
                            ),
                    );
                  })
            ],
          ),
        ));
  }

  bool isVisible(String name) {
    if (query.isEmpty) {
      return true;
    }
    if (name.toLowerCase().contains(query.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  ListTile _buildUserItem(
      UserModel user, String message, String count, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.chatBoxScreen, arguments: user.id);
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: user.profile.toString().isEmpty
            ? ImageConstant.defaultProfile
            : user.profile,
      ),
      trailing: Visibility(
        visible: count != '',
        child: Container(
            padding: EdgeInsets.all(5.h),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Text(
              count,
              style: textTheme.bodySmall!
                  .copyWith(fontSize: 10.fSize, color: Colors.white),
            )),
      ),
      title: Text(
        user.name ?? '',
        style: textTheme.titleMedium,
      ),
      subtitle: Text(
        message,
        style: textTheme.bodySmall,
      ),
    );
  }

  int getUnSeenMessageCount(List<Message> messagesList) {
    int count = 0;
    if (messagesList.isNotEmpty) {
      for (var chat in messagesList) {
        if (!chat.isSeen! && chat.receiverId == PrefUtils.getId()) {
          count++;
        }
      }
    }
    return count;
  }

  String getLastMessage(List<Message> messages) {
    if (messages.isEmpty) {
      return '';
    } else if (messages[0].type == MessageType.Voice.name) {
      return '🎵 ${messages[0].type}';
    } else if (messages[0].type == MessageType.Media.name) {
      return '📂 ${messages[0].type}';
    } else if (messages[0].type == MessageType.Video.name) {
      return '🎥 ${messages[0].type}';
    } else if (messages[0].type == MessageType.Text.name) {
      return '${messages[0].message}';
    } else {
      return '';
    }
  }
}

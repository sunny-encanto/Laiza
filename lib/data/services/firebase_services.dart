// ignore_for_file: sdk_version_since

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_video_thumbnail/get_video_thumbnail.dart';
import 'package:get_video_thumbnail/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laiza/data/models/live_stream_model.dart/live_stream_model.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:laiza/data/services/notification_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';

import '../../core/app_export.dart';
import '../../core/utils/pref_utils.dart';
import '../models/user/user_model.dart';
import 'firebase_messaging_service.dart';
import 'media_services.dart';

class FirebaseServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

/*-----------GOOGLE LOGIN---------------*/
  static Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      return authResult;
    } catch (e) {
      rethrow;
    }
  }

/*-----------APPLE LOGIN---------------*/
  static Future<UserCredential> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in the user with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

/*-------Ad User--------*/
  static Future<bool> addUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
      return true;
    } catch (e) {
      log('Error during add user', error: e);
      return false;
    }
  }

/*-------Update User--------*/
  static Future<bool> updateUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .update(userModel.toJson());
      return true;
    } catch (e) {
      log('Error during update user', error: e);
      return false;
    }
  }

/*-------Get User--------*/
  static Future<UserModel?> getCurrentUser() async {
    try {
      return await _firestore
          .collection('users')
          .doc(PrefUtils.getId())
          .get()
          .then((value) => UserModel.fromJson(
              json: value.data() as Map<String, dynamic>, id: value.id));
    } catch (e) {
      log('Error during get user', error: e);
      return null;
    }
  }

/*-------Get All Chats--------*/
  static getAllChats() {
    try {
      return _firestore
          .collection('chats')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      log('Error during get chats', error: e);
    }
  }

/*-------Upload Files in firebase Storage--------*/
  static Future<String> uploadFile(
      {required String filePath, required String contentType}) async {
    try {
      String base64Data = base64Encode(File(filePath).readAsBytesSync());
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${filePath.split('/').last}';
      debugPrint('fileName:==>$fileName');
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference ref = _storage.ref().child('uploads/$fileName');

      // Set metadata (content type)
      SettableMetadata metadata = SettableMetadata(contentType: contentType);
      // Upload file to Firebase Storage
      UploadTask uploadTask = ref.putData(base64.decode(base64Data), metadata);

      // Await the upload to get the task snapshot
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      log('Error uploading file:', error: e);
      return '';
    }
  }

/*-----Get User By Id---------*/
  static getUserById(String id) {
    return _firestore.collection('users').doc(id).snapshots();
  }

/*-------Send Chat Message--------*/
  static Future<bool> sendMessage({
    required Message message,
  }) async {
    try {
      var chatRef = _firestore.collection('chats').doc(message.roomId);
      chatRef.set({'timestamp': FieldValue.serverTimestamp()});
      chatRef.collection('messages').add(message.toJson());
      return true;
    } catch (e) {
      log('Error during send message', error: e);
      return false;
    }
  }

/*---------Get Chats--------------*/
  static getChats(String receiverId) {
    try {
      return _firestore
          .collection('chats')
          .doc(createChatRoomId(receiverId))
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } catch (e) {
      log('Error during get chats', error: e);
    }
  }

/*---------Get Last Chats--------------*/
  static getLastChats(String receiverId) {
    try {
      return _firestore
          .collection('chats')
          .doc(createChatRoomId(receiverId))
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      log('Error during get chats', error: e);
    }
  }

/*-----Media Chat------*/
  static Future<bool> sendMediaChat(String receiverId) async {
    try {
      Media? media = await MediaServices.pickFilePathAndExtension();
      if (media != null) {
        String roomId = FirebaseServices.createChatRoomId(receiverId);
        String docId = const Uuid().v4();
        final Message message = Message(
          roomId: roomId,
          isSeen: false,
          receiverId: receiverId,
          senderId: PrefUtils.getId(),
          message: '',
          timestamp: DateTime.now().toString(),
          type: MessageType.Media.name,
          url: '',
          fileName: media.name,
          fileExtension: media.fileExtension,
          linkCount: 0,
          userIdsOfUsersForDeletedMessage: [],
        );
        var chatRef = _firestore.collection('chats').doc(roomId);
        chatRef.set({'timestamp': FieldValue.serverTimestamp()});
        chatRef.collection('messages').doc(docId).set(message.toJson());

        // send Push Notification
        FirebaseServices.sendChatNotification(
            type: NotificationType.Chat.name,
            id: receiverId,
            message: '📂 Media');
        String url = await uploadFile(
            filePath: media.path, contentType: media.fileExtension);
        if (media.fileExtension == '.mp4') {
          String? thumbnailUrl = await generateAndUploadThumbnail(url);
          chatRef
              .collection('messages')
              .doc(docId)
              .update({'thumbnailUrl': thumbnailUrl});
        }
        chatRef.collection('messages').doc(docId).update({'url': url});
        return true;
      }
      return false;
    } catch (e) {
      log('Error during sendMedia:', error: e);
      return false;
    }
  }

/*-----Send Chat Notifications------*/
  static void sendChatNotification(
      {required String id,
      required String message,
      required String type}) async {
    try {
      await _firestore.collection('users').doc(id).get().then((value) async {
        UserModel userModel = UserModel.fromJson(
            json: value.data() as Map<String, dynamic>, id: value.id);
        // if (userModel.isNotificationOn ?? true) {
        debugPrint('Token: ${userModel.token}');
        await FirebaseMessagingService.sendNotification(
          type: type,
          token: userModel.token!,
          title: PrefUtils.getUserName(),
          // + "Send You a message".tr,
          body: message,
          id: "${userModel.id}",
        );
        // }
      });
    } catch (e) {
      log('Error during send chat message', error: e);
    }
  }

// /*-----Update Chat------*/
  static updateChat({required String senderId, required docId}) {
    _firestore
        .collection('chats')
        .doc(createChatRoomId(senderId))
        .collection('messages')
        .doc(docId)
        .update({"isSeen": true});
  }

/*-------- Generate Thumbnail from video url -----*/
  static Future<String?> generateAndUploadThumbnail(String videoUrl) async {
    Uint8List? thumbnailData;
    try {
      thumbnailData = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200, // Adjust the thumbnail width as needed
        quality: 25, // Adjust the thumbnail quality as needed
      );
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return null; // Return null in case of an error
    }

    // Initialize Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef =
        storage.ref().child('thumbnails').child('thumbnail.jpg');

    try {
      // Upload thumbnail to Firebase Storage
      TaskSnapshot uploadTask = await storageRef.putData(thumbnailData);

      // Get download URL for the uploaded thumbnail
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading thumbnail to Firebase Storage: $e');
      return null; // Return null in case of an error
    }
  }

/*-------- Add OnGoing LiveStream -----*/
  static Future<void> addOnGoingLiveStream(
      LiveStreamModel liveStreamModel) async {
    await _firestore
        .collection('OnGoingLiveStream')
        .doc(liveStreamModel.liveId)
        .set(liveStreamModel.toMap());
  }

/*--------get OnGoing LiveStream -----*/
  static getOnGoingLiveStream() {
    return _firestore.collection('OnGoingLiveStream').snapshots();
  }

/*--------update OnGoing LiveStream -----*/
  static Future<void> updateOnGoingLiveStream(
      {required String id, required bool isAdd}) async {
    try {
      final docRef = _firestore.collection('OnGoingLiveStream').doc(id);
      final docSnapShot = await docRef.get();
      if (docSnapShot.exists) {
        await docRef.update({
          'viewCount':
              isAdd ? FieldValue.increment(1) : FieldValue.increment(-1),
        });
      }
    } catch (e) {
      log('Error on updateOnGoingLiveStream', error: e);
    }
  }

/*-------- Delete OnGoing LiveStream -----*/
  static Future<void> deleteOnGoingStream(String id) async {
    try {
      await _firestore.collection('OnGoingLiveStream').doc(id).delete();
    } catch (e) {
      debugPrint('Delete OnGoing LiveStream Error : $e');
    }
  }

/*-------- generate unique chat id for one to one user -----*/
  static String createChatRoomId(String receiverId) {
    List<String> userIds = [PrefUtils.getId(), receiverId];
    userIds.sort(); // Sort the user IDs to ensure consistency
    return userIds.join('_');
  }

/*-------- Delete Account -----*/
  static Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        debugPrint("User account deleted successfully.");
      } catch (e) {
        log("Error deleting user account:", error: e);
      }
    } else {
      debugPrint("No user signed in.");
    }
  }

/*-------- Handle SignOut -----*/
  static Future<void> handleLogOut(context) async {
    PrefUtils.clearPreferencesData();
    await googleSignIn.signOut();
    _auth.signOut();
    PrefUtils.setIsNewUser(false);
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.selectRoleScreen, (Route<dynamic> route) => false);
  }

/*-----Get User---------*/
// static getUser() {
//   return _firestore.collection('users').doc(PrefUtils.getId()).snapshots();
// }

/*---------Delete Chats--------------*/
// static deleteChats(String receiverId) async {
//   try {
//     // Get a reference to the collection
//     CollectionReference collectionReference = _firestore
//         .collection('chats')
//         .doc(createChatRoomId(receiverId))
//         .collection('messages');
//     // Get all documents from the collection
//     QuerySnapshot querySnapshot = await collectionReference.get();
//     // Delete each document in the collection
//     querySnapshot.docs.forEach((document) async {
//       await document.reference.delete();
//     });
//   } catch (e) {
//     log('Error during delete chats', error: e);
//   }
// }

// /*-----Voice Message------*/
//   static Future<bool> sendVoiceChat(
//       {required ChatModel chat, required String path}) async {
//     try {
//       // Media? media = await MediaServices.pickFilePathAndExtension();
//       //if (media != null) {
//       String roomId = FirebaseServices.createChatRoomId(chat.receiverId ?? "");
//       String docId = const Uuid().v4();

//       var chatRef = _firestore.collection('chats').doc(roomId);
//       chatRef.set({'timestamp': FieldValue.serverTimestamp()});
//       chatRef.collection('messages').doc(docId).set(chat.toJson());
//       //send Push Notification
//       FirebaseServices.sendChatNotification(
//           type: NotificationType.Chat.name,
//           id: chat.receiverId ?? '',
//           message: '🎤 Voice Message');
//       String url = await uploadFile(filePath: path, contentType: '.mp3');
//       chatRef.collection('messages').doc(docId).update({'url': url});
//       return true;
//     } catch (e) {
//       log('Error during voice chat:', error: e);
//       return false;
//     }
//   }

//   static Future<bool> sendVideoChat(String receiverId) async {
//     try {
//       String filePath = await MediaServices.recordVideo();
//       if (filePath.isNotEmpty) {
//         String roomId = FirebaseServices.createChatRoomId(receiverId);
//         String docId = const Uuid().v4();
//         final chat = ChatModel(
//           roomId: roomId,
//           isSeen: false,
//           receiverId: receiverId,
//           senderId: PrefUtils.getId(),
//           timestamp: DateTime.now().toString(),
//           type: MessageType.Video.name,
//           url: '',
//           fileExtension: '.mp4',
//         );
//         var chatRef = _firestore.collection('chats').doc(roomId);
//         chatRef.set({'timestamp': FieldValue.serverTimestamp()});
//         chatRef.collection('messages').doc(docId).set(chat.toJson());

//         //Send Push Notification
//         FirebaseServices.sendChatNotification(
//             type: NotificationType.Chat.name,
//             id: receiverId,
//             message: "🎥 Video");
//         String url = await uploadFile(filePath: filePath, contentType: '.mp4');
//         chatRef.collection('messages').doc(docId).update({'url': url});
//         String? thumbnailUrl = await generateAndUploadThumbnail(url);
//         chatRef
//             .collection('messages')
//             .doc(docId)
//             .update({'thumbnailUrl': thumbnailUrl});
//         return true;
//       }
//       return false;
//     } catch (e) {
//       log('Error during send video:', error: e);
//       return false;
//     }
//   }

// static Future<bool> checkEmailExists(String email) async {
//   try {
//     // Fetch sign-in methods for the email address
//     final list =
//         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

//     // In case list is not empty
//     if (list.isNotEmpty) {
//       // Return true because there is an existing
//       // user using the email address
//       return true;
//     } else {
//       // Return false because email  is not in use
//       return false;
//     }
//   } catch (error) {
//     // Handle error
//     return true;
//   }
// }
}

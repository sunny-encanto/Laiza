import 'package:dio/dio.dart';
import 'package:laiza/data/models/comments_model/comment.dart';
import 'package:laiza/data/models/comments_model/comments_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/services/apiClient/dio_client.dart';

import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/comment_reply_model/comment_reply_model.dart';

class CommentsRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> addComment(
      {required int reelId, required String comment}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'reel_id': reelId, 'comment': comment});
      Response response =
          await _apiClient.post(ApiConstant.addComment, data: data);

      if (response.statusCode == 200) {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      } else {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during add Comment', e.toString());
      throw Exception('Failed to add Comment');
    }
  }

  Future<List<Comment>> getComment(int reelId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get('${ApiConstant.allComment}/$reelId');
      if (response.statusCode == 200) {
        CommentModel model = CommentModel.fromJson(response.data);
        return model.comment;
      } else {
        CommentModel model = CommentModel.fromJson(response.data);
        return model.comment;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get Comment', e.toString());
      throw Exception('Failed to get Comment');
    }
  }

  Future<CommonModel> updateComment() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.updateComment);
      if (response.statusCode == 200) {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      } else {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during update Comment', e.toString());
      throw Exception('Failed to update Comment');
    }
  }

  Future<CommonModel> deleteComment(int commentId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.post("${ApiConstant.deleteComment}/$commentId");
      if (response.statusCode == 200) {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      } else {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during delete Comment', e.toString());
      throw Exception('Failed to delete Comment');
    }
  }

  Future<List<Comment>> getCommentReply(int commentId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response =
          await _apiClient.get('${ApiConstant.commentReply}/$commentId');
      if (response.statusCode == 200) {
        CommentReplyModel model = CommentReplyModel.fromJson(response.data);
        return model.data;
      } else {
        CommentReplyModel model = CommentReplyModel.fromJson(response.data);
        return model.data;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get comment reply', e.toString());
      throw Exception('Failed to get comment reply');
    }
  }

  Future<CommonModel> addCommentReply(
      {required int commentId, required String reply}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data =
          FormData.fromMap({'comment_id': commentId, 'reply': reply});
      Response response =
          await _apiClient.post(ApiConstant.addCommentReply, data: data);

      if (response.statusCode == 200) {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      } else {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during add comment reply', e.toString());
      throw Exception('Failed to add comment reply');
    }
  }
}

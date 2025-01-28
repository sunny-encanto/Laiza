import 'package:dio/dio.dart';
import 'package:laiza/core/network/dio_client.dart';
import 'package:laiza/data/models/comments_model/comment.dart';
import 'package:laiza/data/models/comments_model/comments_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';

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

  Future<CommonModel> updateComment(
      {required int commentId,
      required String comment,
      required int reelId}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'reel_id': reelId, 'comment': comment});
      Response response = await _apiClient
          .post("${ApiConstant.updateComment}/$commentId", data: data);
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

  Future<CommonModel> deleteSubComment(int commentId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.post("${ApiConstant.deleteSubComment}/$commentId");
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
      Logger.log('Error during delete SubComment', e.toString());
      throw Exception('Failed to delete SubComment');
    }
  }

  Future<CommonModel> addCommentReply(
      {required int commentId, required String reply}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap(
          {'comment_id': commentId, 'parent_id': commentId, 'comment': reply});
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

  Future<CommonModel> addCommentLike(int commentId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'comment_id': commentId});
      Response response =
          await _apiClient.post(ApiConstant.addCommentLike, data: data);

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
      Logger.log('Error during add comment like', e.toString());
      throw Exception('Failed to add comment like');
    }
  }

  Future<CommonModel> addSubCommentLike(int commentId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'sub_comment_id': commentId});
      Response response =
          await _apiClient.post(ApiConstant.addSubCommentLike, data: data);

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
      Logger.log('Error during add subComment like', e.toString());
      throw Exception('Failed to add subComment like');
    }
  }
}

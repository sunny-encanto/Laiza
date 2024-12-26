import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/followers_model/follower.dart';
import 'package:laiza/data/models/followers_model/followers_model.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/following_model/following_model.dart';
import '../../services/apiClient/dio_client.dart';

class FollowersRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Follower>> getFollowers() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.followers);
      if (response.statusCode == 200) {
        FollowersModel model = FollowersModel.fromJson(response.data);
        return model.followers;
      } else {
        FollowersModel model = FollowersModel.fromJson(response.data);
        return model.followers;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get followers', e.toString());
      throw Exception('Failed to get followers');
    }
  }

  Future<List<Follower>> getFollowings() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.following);
      if (response.statusCode == 200) {
        FollowingModel model = FollowingModel.fromJson(response.data);
        return model.followers;
      } else {
        FollowersModel model = FollowersModel.fromJson(response.data);
        return model.followers;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get followers', e.toString());
      throw Exception('Failed to get followers');
    }
  }

  Future<CommonModel> follower(String id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.post('${ApiConstant.follow}/$id');
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during follow Influencer', e.toString());
      throw Exception('Failed to follow Influencer');
    }
  }

  Future<CommonModel> unFollow(String id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.post('${ApiConstant.unfollow}/$id');
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during follow Influencer', e.toString());
      throw Exception('Failed to follow Influencer');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/all_influencer_model/all_influencer_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/models/user_profile_model/user_profile_model.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/api_constant.dart';
import '../../services/apiClient/dio_client.dart';

class UserRepository {
  final ApiClient _apiClient = ApiClient();

  Future<UserModel> getUserProfile() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.profile);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        UserProfileModel model = UserProfileModel.fromJson(responseData);
        return UserModel.fromJson(
            json: model.data!.user!.toJson(),
            id: model.data!.user!.id.toString());
      } else {
        var responseData = await response.data;
        UserProfileModel model = UserProfileModel.fromJson(responseData);
        return UserModel.fromJson(
            json: model.data!.user!.toJson(),
            id: model.data!.user!.id.toString());
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get user profile', e.toString());
      throw Exception('Failed to get user profile');
    }
  }

  Future<CommonModel> updateUserProfile(UserModel user) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      // Prepare map data
      final Map<String, dynamic> data = user.toJson();

      // Conditionally add the image key if the profile image is available
      if (user.profileImg != null && !user.profileImg!.contains('https:')) {
        data['profile_img'] = await MultipartFile.fromFile(
          user.profileImg!,
          filename: user.profileImg!.split('/').last,
        );
      }
      // Create FormData from the map
      FormData formData = FormData.fromMap(data);

      Response response =
          await _apiClient.post(ApiConstant.updateProfile, data: formData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  Update User Profiler', e.toString());
      throw Exception('Failed to update user profile');
    }
  }

  Future<List<UserModel>> getAllInfluencer() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.allInfluencers);
      if (response.statusCode == 200) {
        AllInfluencerModel model = AllInfluencerModel.fromJson(response.data);
        return model.influencers ?? <UserModel>[];
      } else {
        AllInfluencerModel model = AllInfluencerModel.fromJson(response.data);
        return model.influencers ?? <UserModel>[];
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  Get all influencer', e.toString());
      throw Exception('Failed to get all influencers');
    }
  }
}

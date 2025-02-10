import 'package:dio/dio.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/models/reels_model/reels_model.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';

class ReelRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Reel>> getMyReels() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.myReel);
      if (response.statusCode == 200) {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      } else {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get Reels', e.toString());
      throw Exception('Failed to get Reels');
    }
  }

  Future<List<Reel>> getAllReels() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.allReel);
      if (response.statusCode == 200) {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      } else {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get Reels', e.toString());
      throw Exception('Failed to get Reels');
    }
  }

  Future<List<Reel>> getAllReelsFromFollowedInfluencer() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response =
          await _apiClient.get(ApiConstant.allReelFromFollowedInfluencer);
      if (response.statusCode == 200) {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      } else {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get Reels', e.toString());
      throw Exception('Failed to get Reels');
    }
  }

  Future<CommonModel> addReel({
    required List<String> productIds,
    required String reelTitle,
    required String reelDes,
    required String reelPath,
    required String coverPath,
    required String hashTag,
  }) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData formData = FormData.fromMap({
        'product_id[]': productIds,
        'reel_title': reelTitle,
        'reel_description': reelDes,
        'reel_hashtag': hashTag,
        'reel_cover_path': await MultipartFile.fromFile(coverPath,
            filename: coverPath.split('/').last),
        'reel_path': await MultipartFile.fromFile(reelPath,
            filename: reelPath.split('/').last)
      });
      Response response =
          await _apiClient.post(ApiConstant.addReel, data: formData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during add Reels', e.toString());
      throw Exception('Failed to add Reels');
    }
  }

  Future<CommonModel> addReelLike(int reelId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData formData = FormData.fromMap({'reel_id': reelId});
      Response response =
          await _apiClient.post(ApiConstant.likeReel, data: formData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during like Reels', e.toString());
      throw Exception('Failed to like Reels');
    }
  }

  Future<CommonModel> removeReelLike(int reelId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData formData = FormData.fromMap({'reel_id': reelId});
      Response response =
          await _apiClient.post(ApiConstant.removeReelLike, data: formData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during like Reels', e.toString());
      throw Exception('Failed to like Reels');
    }
  }

  Future<CommonModel> deleteReel(int reelId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData formData = FormData.fromMap({'reel_id': reelId});
      Response response = await _apiClient
          .delete("${ApiConstant.deleteReel}/$reelId", data: formData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during like Reels', e.toString());
      throw Exception('Failed to like Reels');
    }
  }

  Future<CommonModel> updateReel(Reel reel) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      final Map<String, dynamic> data = reel.toJson();

      // Conditionally add the image key if the profile image is available
      if (!reel.reelCoverPath.contains('https:')) {
        data['reel_cover_path'] = await MultipartFile.fromFile(
          reel.reelCoverPath,
          filename: reel.reelCoverPath.split('/').last,
        );
      } else {
        data['reel_cover_path'] = null;
      }
      data['product_id[]'] = reel.productId;
      data.remove('product_id');
      // Create FormData from the map
      FormData formData = FormData.fromMap(data);
      Response response = await _apiClient
          .post('${ApiConstant.updateReel}/${reel.id}', data: formData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during update Reels', e.toString());
      throw Exception('Failed to update Reels');
    }
  }
}

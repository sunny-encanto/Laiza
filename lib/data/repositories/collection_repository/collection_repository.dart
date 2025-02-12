import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/collection_model/collection_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/influencer_profile_model/influencer_profile_model.dart';

class CollectionRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> addCollection(
      {required String title, required List<String> reelIds}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'title': title, 'reel_ids[]': reelIds});
      Response response =
          await _apiClient.post(ApiConstant.addCollection, data: data);
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
      Logger.log('Error during  add collection', e.toString());
      throw Exception('Failed to add collection');
    }
  }

  Future<List<Collection>> getCollection() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient
          .get(ApiConstant.getCollection, queryParameters: {'paginate': false});
      if (response.statusCode == 200) {
        CollectionModel model = CollectionModel.fromJson(response.data);
        return model.collection;
      } else {
        CollectionModel model = CollectionModel.fromJson(response.data);
        return model.collection;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get collection', e.toString());
      throw Exception('Failed to get collection');
    }
  }

  Future<List<Collection>> getCollectionDetails(int id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(
          '${ApiConstant.getCollectionDetails}/$id',
          queryParameters: {'paginate': false});
      if (response.statusCode == 200) {
        CollectionModel model = CollectionModel.fromJson(response.data);
        return model.collection;
      } else {
        CollectionModel model = CollectionModel.fromJson(response.data);
        return model.collection;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get collection Details', e.toString());
      throw Exception('Failed to get collection Details');
    }
  }

  Future<CommonModel> deleteCollection(int id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response =
          await _apiClient.delete('${ApiConstant.deleteCollection}/$id');
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
      Logger.log('Error during delete collection ', e.toString());
      throw Exception('Failed to delete collection');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/upcoming_stream_model/upcoming_stream_model.dart';

class LiveStreamRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> addStream({
    required String title,
    required String description,
    required String date,
    required String time,
    required List<String> productIds,
  }) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'product_id[]': productIds,
      });
      Response response =
          await _apiClient.post(ApiConstant.addStream, data: data);
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
      Logger.log('Error during add stream', e.toString());
      throw Exception('Failed to add stream');
    }
  }

  Future<List<UpComingStream>> getAllStream() async {
    try {
      _apiClient.setHeaders({
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNDQyZWM4MzkzYTJhMzczNjRlYWNkZTQ4ZWQyZTVkZjk0MmQ0YjE3NTAzNjVhODlmYTQyM2FiYjYyNTg4NmIxNmNiMWRkYzA3ZTk0OTQ2OTYiLCJpYXQiOjE3Mzg2NTIxNzIuMTY4OTExLCJuYmYiOjE3Mzg2NTIxNzIuMTY4OTEzLCJleHAiOjE3NzAxODgxNzIuMTY2Nzk2LCJzdWIiOiIyOTAiLCJzY29wZXMiOltdfQ.YsUugqExxdrlqLo7R0-0HNbV4JdnU3KtN76lx2ZmXL1W9C5CJ7EiAECxPdwiSHEPjEE14d4ujL9nAD40s-P-nhsJgmB4FBRmfVj135jQj1xlQH_k6fnN2W1KBW2iNNp1Ab7e_hw3G5kCu5UMHhHWDx98dbnyrMQa2mkPiKmgJGhwfzwRCivlRbjVTlPnbyoiWXCKNsg1a1yDtmT_4pzxdVnf1d7aOI6Rf3acRlJPn-kfrhYOkPcESv-LfmHv_UZA6R02MjJIEpyriEAi7MtC64IdqURvGEN73skdY6xDZTlSnOV_2rBiwac_kEM1aEgI6i9Z0yTOXkyhbtHMt57dUP10-qNKCvM1u6p3jYsx_McRrb7d8G8QMUlM4z0rikYM7sMm1mgKUBqdUwYWUFoZ9RJnHB7BDhZAtTfuMQFT9h7KrXu4USBWXZK3D3KLoegPQ3U8tTpjoO9Okd6y8NUurhJtyGBmTqaqgxf7XtQbYMwBKIPfCETEBGPKZdVt0vuZmUBb0k3sgPMRxljaz1nVEluR7kjlvwMpkby2TQWYwSFNHk5sZRPShjzXU4peLcBQfauyBFI5h7dDRgexDElfeCNH5MEZL76PKelj9qEpavTv9RiVPMxeceqOr-e_qRjErUzGXiC8nlNF8v4nOlIMvDAjcudv9s79a9he0xAP0hQ'
      });
      Response response = await _apiClient
          .get(ApiConstant.getAllStream, queryParameters: {'paginate': false});
      if (response.statusCode == 200) {
        UpComingStreamModel model = UpComingStreamModel.fromJson(response.data);
        return model.upComingStream;
      } else {
        UpComingStreamModel model = UpComingStreamModel.fromJson(response.data);
        return model.upComingStream;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get upcoming stream', e.toString());
      throw Exception('Failed to get upcoming stream');
    }
  }
}

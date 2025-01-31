import 'package:dio/dio.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/connection_request_model/connection_request_model.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/my_connections_model/my_connections_model.dart';

class ConnectionsRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> sendConnection(int id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data =
          FormData.fromMap({'receiver_id': id, 'receiver_type': 'seller'});
      Response response =
          await _apiClient.post(ApiConstant.sendConnection, data: data);
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
      Logger.log('Error during send connections', e.toString());
      throw Exception('Failed to send connections');
    }
  }

  Future<List<ConnectionRequest>> getConnectionRequests() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.getRequests);
      if (response.statusCode == 200) {
        ConnectionRequestModel model =
            ConnectionRequestModel.fromJson(response.data);
        return model.requests;
      } else {
        ConnectionRequestModel model =
            ConnectionRequestModel.fromJson(response.data);
        return model.requests;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get connections Requests', e.toString());
      throw Exception('Failed to get connections Requests');
    }
  }

  Future<List<Connection>> getMyConnections() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.getMyConnections);
      if (response.statusCode == 200) {
        MyConnectionsModel model = MyConnectionsModel.fromJson(response.data);
        return model.connections;
      } else {
        MyConnectionsModel model = MyConnectionsModel.fromJson(response.data);
        return model.connections;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get my connections', e.toString());
      throw Exception('Failed to get my connections');
    }
  }

  Future<CommonModel> acceptRejectConnection(
      {required int id, required ConnectionRequestStatus status}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'status': status.name});
      Response response = await _apiClient
          .post("${ApiConstant.acceptRejectConnections}/$id", data: data);
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
      Logger.log('Error during accept-Reject connections', e.toString());
      throw Exception('Failed to accept-Reject connections');
    }
  }
}

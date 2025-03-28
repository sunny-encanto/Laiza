import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../models/notifications_model/notifications_model.dart';

class NotificationRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Notification>> getNotifications() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.notification);
      if (response.statusCode == 200) {
        NotificationModel model = NotificationModel.fromJson(response.data);
        return model.notifications;
      } else {
        NotificationModel model = NotificationModel.fromJson(response.data);
        return model.notifications;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get followers', e.toString());
      throw Exception('Failed to get Notifications');
    }
  }
}

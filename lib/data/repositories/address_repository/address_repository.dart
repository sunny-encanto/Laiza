import 'package:dio/dio.dart';
import 'package:laiza/data/models/address_model/address_type_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/address_model/address_model.dart';
import '../../models/address_model/default_address_model.dart';

class AddressRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> addAddress(Address address) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData fromData = FormData.fromMap(address.toJson());
      Response response =
          await _apiClient.post(ApiConstant.addAddress, data: fromData);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during add address', e.toString());
      throw Exception('Failed to add address');
    }
  }

  Future<List<Address>> getAddress() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.getAddress);
      if (response.statusCode == 200) {
        AddressModel addressModel = AddressModel.fromJson(response.data);
        return addressModel.addressList ?? <Address>[];
      } else {
        AddressModel addressModel = AddressModel.fromJson(response.data);
        return addressModel.addressList ?? <Address>[];
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get address', e.toString());
      throw Exception('Failed to get address');
    }
  }

  Future<List<AddressType>> getAddressType() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.getAddressType);
      if (response.statusCode == 200) {
        AddressTypeModel addressModel =
            AddressTypeModel.fromJson(response.data);
        return addressModel.addressType;
      } else {
        AddressTypeModel addressModel =
            AddressTypeModel.fromJson(response.data);
        return addressModel.addressType;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get address Type', e.toString());
      throw Exception('Failed to get address Type');
    }
  }

  Future<CommonModel> deleteAddress(int id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.delete("${ApiConstant.deleteAddress}/$id");
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get address Type', e.toString());
      throw Exception('Failed to get address Type');
    }
  }

  Future<Address> getDefaultAddress() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.getDefaultAddress);
      if (response.statusCode == 200) {
        DefaultAddressModel addressModel =
            DefaultAddressModel.fromJson(response.data);
        return addressModel.address;
      } else {
        DefaultAddressModel addressModel =
            DefaultAddressModel.fromJson(response.data);
        return addressModel.address;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get default address', e.toString());
      throw Exception('Failed to get default address');
    }
  }
}

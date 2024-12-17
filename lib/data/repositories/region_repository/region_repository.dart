import 'package:dio/dio.dart';
import 'package:laiza/data/models/city_model/city_model.dart';
import 'package:laiza/data/models/countries/countries_model.dart';
import 'package:laiza/data/models/countries/country.dart';
import 'package:laiza/data/models/states_model/state.dart';
import 'package:laiza/data/models/states_model/states_model.dart';

import '../../../core/utils/api_constant.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/city_model/city.dart';
import '../../services/apiClient/dio_client.dart';

class RegionRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Country>> getCountries() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.getCountries);
      if (response.statusCode == 200) {
        CountriesModel model = CountriesModel.fromJson(response.data);
        return model.countries;
      } else {
        CountriesModel model = CountriesModel.fromJson(response.data);
        return model.countries;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to get user profile');
    }
  }

  Future<List<State>> getStates(int countryId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get('${ApiConstant.getStates}/$countryId');
      if (response.statusCode == 200) {
        StatesModel model = StatesModel.fromJson(response.data);
        return model.states;
      } else {
        StatesModel model = StatesModel.fromJson(response.data);
        return model.states;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to get user profile');
    }
  }

  Future<List<City>> getCities(int stateId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get('${ApiConstant.getCities}/$stateId');
      if (response.statusCode == 200) {
        CityModel model = CityModel.fromJson(response.data);
        return model.cities;
      } else {
        CityModel model = CityModel.fromJson(response.data);
        return model.cities;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to get user profile');
    }
  }
}

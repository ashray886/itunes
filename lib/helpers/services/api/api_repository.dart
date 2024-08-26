import 'package:dio/dio.dart';
import 'package:itunes/config/api_path.dart';
import 'package:itunes/helpers/services/api/api_services.dart';
import 'package:itunes/models/itunes_model.dart';

class ApiRepository {
  Future<ITunesModel> fetchSearch({required String params}) async {
    //String limit = "&limit=20";
    RestAPIService restAPIService = RestAPIService(Dio());
    var result = await restAPIService.getService(
      url: ITunesAPI.searchUrl + params,
    );
    return iTunesModelFromJson(result);
  }
}

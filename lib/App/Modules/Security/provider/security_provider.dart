import 'package:dio/dio.dart';
import 'package:e_jareemah/App/Models/Main/DTO/check_url.dart';
import 'package:e_jareemah/App/Models/Main/Response/check_url_response.dart';

class SecurityProvider {
  Future<void> checkURL(
      {Function(CheckURLResponse data)? onSuccess,
      Function(dynamic error)? onError,
      required CheckURLDTO checkURLDTO}) async {
    try {
      await Dio()
          .post(
              'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=AIzaSyDMqgs5vV7NtzWOwW8nJZgyVUICiVgq5_k',
              data: checkURLDTO.toJson())
          .then((response) {
        if (onSuccess != null) {
          onSuccess(CheckURLResponse.fromJson(response.data));
        }
      });
    } on DioException catch (error) {
      if (onError != null) onError(error);
    }
  }
}

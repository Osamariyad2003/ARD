
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.weatherapi.com/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async
  {
    dio.options.headers =
    {
      'lang':lang,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }}



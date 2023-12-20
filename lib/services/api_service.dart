import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pagination_task/services/connectivity_service.dart';
import 'package:pagination_task/services/interceptors.dart';

class ApiService {
  final String _baseUrl = 'https://dummyjson.com';
  Dio? _dio;

  static ApiService instance = ApiService._();

  ApiService._();

  Future<Dio> get dio async {
    _dio ??= Dio(
      BaseOptions(validateStatus: (int? status) {
        return status! >= 200 && status < 300 || status == 304;
      }),
    )..interceptors.addAll([
        DioCacheInterceptor(options: await CacheInterceptorConfig.getCacheOptions()),
        LoggingInterceptor(),
      ]);
    return _dio!;
  }

  Future<dynamic> get(String path, [Map<String, dynamic> params = const {}]) async {
    try {
      if (!(await ConnectivityService.isConnectedToInternet())) throw 'No internet connection';

      final response = await (await dio).get('$_baseUrl$path', queryParameters: params);
      // if (response.statusCode != 200) throw 'Error => Status code ${response.statusCode}';

      return response.data;
    } catch (e) {
      throw e.toString();
    }
  }
}

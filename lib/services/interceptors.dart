import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\x1B[34m -----------------------------------------------------------\n'
        ' Api Called: ${options.path} \n Parameters: ${options.queryParameters} \n '
        '-----------------------------------------------------------\x1B[0m');

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\x1B[31m -----------------------------------------------------------\n'
        ' Error: ${err.error} \n Message: ${err.message} \n '
        '-----------------------------------------------------------\x1B[0m');

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\x1B[32m -----------------------------------------------------------\n'
        ' Response: ${response.data}  \n '
        '-----------------------------------------------------------\x1B[0m');
    handler.next(response);
  }
}

class CacheInterceptorConfig {
  static const _boxName = 'products_cache';

  static Future<CacheOptions> getCacheOptions() async {
    final cacheDir = await getTemporaryDirectory();

    return CacheOptions(
      store: HiveCacheStore(
        cacheDir.path,
        hiveBoxName: _boxName,
      ),
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(minutes: 5),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );
  }

// static late Directory cacheDir;
// static late HiveCacheStore cacheStore;
//
// CustomDioCacheInterceptor({CacheOptions? customCacheOptions}) : super(options: customCacheOptions ?? defaultCacheOptions) {
//   _initializeCache();
// }
//
// void _initializeCache() async {
//   cacheDir = await getTemporaryDirectory();
//
//   cacheStore = HiveCacheStore(
//     cacheDir.path,
//     hiveBoxName: "products_cache",
//   );
// }
//
// static CacheOptions defaultCacheOptions = CacheOptions(
//   store: HiveCacheStore(
//     cacheDir.path,
//     hiveBoxName: "products_cache",
//   ),
//   policy: CachePolicy.forceCache,
//   priority: CachePriority.high,
//   maxStale: const Duration(minutes: 5),
//   hitCacheOnErrorExcept: [401, 404],
//   keyBuilder: (request) {
//     return request.uri.toString();
//   },
//   allowPostMethod: false,
// );
}

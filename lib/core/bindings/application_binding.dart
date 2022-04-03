import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/core/data/constants.dart';
import 'package:news_app_demo/core/network/logging_interceptor.dart';

/// app level dependencies setup
class ApplicationBinding implements Bindings {

  // setting up Dio configuration
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: URLs.host,
      connectTimeout: AppLimit.REQUEST_TIME_OUT,
      receiveTimeout: AppLimit.REQUEST_TIME_OUT,
      sendTimeout: AppLimit.REQUEST_TIME_OUT,
    );

    var dio = Dio(options);

    // adding interceptors for logging networking
    dio.interceptors.add(LoggingInterceptor());

    return dio;
  }

  @override
  void dependencies() {
    Get.lazyPut(
      _dio,
    );
  }
}

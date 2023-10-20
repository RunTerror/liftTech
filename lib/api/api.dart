import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final _dio = Dio();

  Api() {
    _dio.options.receiveTimeout= const Duration(seconds: 20);
    _dio.options.connectTimeout= const Duration(seconds: 20);
    _dio.options.baseUrl='https://api.escuelajs.co/api/v1';
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendrequest => _dio;
}

import 'package:dio/dio.dart';

class DioManager {
  Dio _dio;

  DioManager._internal() {
    this._dio = new Dio();
  }

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  Dio getDio() {
    return _dio;
  }
}

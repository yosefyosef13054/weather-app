import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:requests_inspector/requests_inspector.dart';

class ApiProvider {
  // https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key}

  //google api key AIzaSyAVQIV6VKriXRjoBg0Nzp8OpBzmZitvayM
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org/data/2.5/weather?',
      headers: _header,
    ),
  )..interceptors.add(RequestsInspectorInterceptor());

  static Map<String, String> get _header {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (Platform.isAndroid) {
      headers['platform'] = 'userandroid';
      headers['device_type'] = 'android';
    } else if (Platform.isIOS) {
      headers['platform'] = 'userios';
      headers['device_type'] = 'ios';
    }
    return headers;
  }

  static Future<Response<dynamic>?> getRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<dynamic, dynamic>? body,
    Map<String, dynamic>? headers,
    bool displayLog = true,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        data: body,
      );

      return response;
    } on DioException catch (e) {
      if (!displayLog || e.response?.statusCode == 404) {
        return null;
      }

      return null;
    } catch (e, stackTrace) {
      return null;
    }
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_myapp/models/geocoding.dart';
import 'package:weather_myapp/provider/weather_provider.dart';
import 'package:weather_myapp/service/api_key.dart';
import 'package:weather_myapp/service/logging.dart';

import '../models/geocoding.dart';
import '../models/hovercast_reader.dart';

String? city = "ankara";

final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api.openweathermap.org/data/2.5/",
    connectTimeout: 5000,
    receiveTimeout: 3000))
  ..interceptors.add(Logging());

@override
Future<dynamic> getCurrentData(String context) async {
  var weatherModel;

  String keyCurrent = apiKeyCurrent;
  city = context.toString();

  try {
    final response = await _dio.get(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$keyCurrent"
        "&units=metric");
    weatherModel = geocodingModel.fromJson(response.data);

    return weatherModel;
  } catch (e) {
    return e;
  }
}

@override
Future<dynamic> getHourlyData(context) async {
  var hourlyModel;
  String keyHourly = apiKeyHovercast;

  try {
    final response = await _dio.get(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$keyHourly"
        "&units=metric");

    hourlyModel = HovercastReader.fromJson(response.data);

    return hourlyModel;
  } catch (e) {
    if (e is DioError) {
      return e;
    }
  }
}

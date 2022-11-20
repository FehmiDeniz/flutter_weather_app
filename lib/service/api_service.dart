import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_myapp/models/geocoding.dart';
import 'package:weather_myapp/provider/weather_provider.dart';
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
Future<geocodingModel?> getCurrentData(String context) async {
  geocodingModel weatherModel;

  city = context.toString();

  final response = await _dio.get(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=33a5bfc0e1e90e645d0ca3bb5ad1c70e"
      "&units=metric");
  weatherModel = geocodingModel.fromJson(response.data);
  return weatherModel;
}

@override
Future<dynamic> getHourlyData(context) async {
  HovercastReader? hourlyModel;

  try {
    final response = await _dio.get(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=07de6e352cc77e781ec578c937639967"
        "&units=metric");

    hourlyModel = HovercastReader.fromJson(response.data);

    return hourlyModel;
  } catch (e) {
    log(e.toString());
  }
  return null;
}

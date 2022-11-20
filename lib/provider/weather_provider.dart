import 'package:flutter/cupertino.dart';

import 'package:weather_myapp/models/geocoding.dart';
import 'package:weather_myapp/models/hovercast_reader.dart';
import 'package:weather_myapp/service/api_service.dart';

class WeatherProvider with ChangeNotifier {
  geocodingModel response = geocodingModel();
  bool isCurrentLoading = false;
  bool isHourlyLoading = false;
  bool isDailyLoading = false;

  getWeatherData(context) async {
    isCurrentLoading = false;
    notifyListeners();

    response = (await getCurrentData(
      context,
    ))!;

    isCurrentLoading = true;
    notifyListeners();

    //
  }

  HovercastReader hresponse = HovercastReader();

  getDataHourly(context) async {
    isHourlyLoading = false;
    isDailyLoading = false;

    notifyListeners();

    hresponse = (await getHourlyData(context))!;
    isHourlyLoading = true;
    isDailyLoading = true;
    notifyListeners();
  }
}

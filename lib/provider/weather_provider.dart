import 'package:flutter/cupertino.dart';

import 'package:weather_myapp/models/geocoding.dart';
import 'package:weather_myapp/models/hovercast_reader.dart';
import 'package:weather_myapp/service/api_service.dart';

class WeatherProvider with ChangeNotifier {
  var response;
  bool isCurrentLoading = false;
  bool isHourlyLoading = false;
  bool isDailyLoading = false;
  bool isTodayLoading = false;

  getWeatherData(context) async {
    isCurrentLoading = false;
    isTodayLoading = false;
    notifyListeners();

    response = (await getCurrentData(
      context,
    ))!;

    if (response.runtimeType == geocodingModel) {
      isCurrentLoading = true;
      isTodayLoading = true;
    } else {
      print(response.message);
    }

    notifyListeners();

    //
  }

  var hresponse;

  getDataHourly(context) async {
    isTodayLoading = false;
    isHourlyLoading = false;
    isDailyLoading = false;

    notifyListeners();

    hresponse = (await getHourlyData(context))!;
    if (hresponse.runtimeType == HovercastReader) {
      isHourlyLoading = true;
      isTodayLoading = true;
      isDailyLoading = true;
    } else {
      print(hresponse.message);
    }

    notifyListeners();
  }
}

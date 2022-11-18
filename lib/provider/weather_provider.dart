import 'package:flutter/cupertino.dart';
import 'package:weather_myapp/models/current_reader_response.dart';
import 'package:weather_myapp/models/hovercast_reader.dart';
import 'package:weather_myapp/service/api_service.dart';

class WeatherProvider with ChangeNotifier {
  CurrentWeatherModel response = CurrentWeatherModel();
  bool isLoading = true;
  bool isHourlyLoaded = false;

  getWeatherData(context) async {
    isLoading = true;
    notifyListeners();

    response = (await getCurrentData(context));
    isLoading = false;
    notifyListeners();

    //
  }

  HovercastReader hresponse = HovercastReader();

  getDataHourly(context) async {
    isHourlyLoaded = false;
    notifyListeners();
    print(isHourlyLoaded);

    hresponse = (await getHourlyData(context))!;
    isHourlyLoaded = true;
    notifyListeners();
    print(isHourlyLoaded);
  }
}

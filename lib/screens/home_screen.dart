import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import 'package:weather_myapp/provider/weather_provider.dart';
import 'package:weather_myapp/screens/weather_details.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<String> weatherDataImage = [
    "assets/im_lightning.png",
    "assets/im_lightning.png",
    "assets/im_lightning.png",
    "assets/im_lightning.png",
  ];
  List<int> weatherDataTemperature = [20, 20, 19, 19];
  List<String> weatherDataClock = [
    "4.00 PM",
    "5.00 PM",
    "6.00 PM",
    "7.00 PM",
  ];
  WeatherProvider? wetProvider;
  @override
  void initState() {
    super.initState();

    wetProvider = Provider.of<WeatherProvider>(
      context,
      listen: false,
    );
  }

  String datetime = DateTime.now().toString();
  String hourData = DateFormat("HH:mm a").format(DateTime.now());
  String lct = "";

  @override
  // void _onRefresh() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   Provider.of<WeatherProvider>(context, listen: false)
  //       .getWeatherData(wetProvider);
  // }

  final locateController = TextEditingController();

  @override
  void dispose() {
    locateController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 10, right: 10),
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 4.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 24,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Container(
                            width: 30.w,
                            height: 10.h,
                            child: TextField(
                              controller: locateController,
                              showCursor: false,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Location'),
                            ),
                          ),
                          Spacer(),
                          Consumer(
                            builder: (BuildContext context,
                                WeatherProvider value, Widget? child) {
                              return IconButton(
                                  onPressed: () {
                                    lct = locateController.text;

                                    if (lct == "") {
                                      AlertMessage(context);
                                    } else {
                                      value.getWeatherData(lct);
                                      value.getDataHourly(lct);
                                      print(lct);

                                      print(context);
                                      // print(value.response.coord!.lat);

                                    }
                                  },
                                  icon: const Icon(Icons.search));
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Consumer(builder: (context, WeatherProvider value, child) {
                      return value.isCurrentLoading == true
                          ? Container(
                              width: 50.w,
                              height: 23.h,
                              decoration: BoxDecoration(
                                  color: Color(0xff4F7FFA),
                                  borderRadius: BorderRadius.circular(3.w)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "${wetProvider?.response.name}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          Spacer(),
                                          Text(
                                            "$hourData",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 90.w,
                                      height: 13.h,
                                      child: Row(
                                        children: [
                                          Image.network(
                                              "https://openweathermap.org/img/wn/${value.response.weather![0].icon!}@2x.png"),
                                          Container(
                                            // padding: EdgeInsets.only(left: 10),
                                            width: 58.w,
                                            height: 13.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Container(
                                                  width: 60.w,
                                                  child: Text(
                                                    "${wetProvider?.response.main?.temp!.toStringAsFixed(1)}°C",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Container(
                                                  width: 60.w,
                                                  child: Text(
                                                    "${wetProvider?.response.weather?[0].main}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 90.w,
                                      height: 4.4.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Son Güncelleme $hourData",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                // _onRefresh();
                                              },
                                              icon: const Icon(
                                                Icons.refresh,
                                                color: Colors.white,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Shimmer(
                              gradient: _shimmerGradient,
                              child: Container(
                                width: 50.w,
                                height: 23.h,
                                decoration: BoxDecoration(
                                    color: Color(0xff4F7FFA),
                                    borderRadius: BorderRadius.circular(3.w)),
                              ),
                            );
                    }),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 80.w,
                      height: 5.h,
                      child: Text(
                        "Hourly Weather Forecast",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 15.h,
                      child: Consumer(
                        builder: (context, WeatherProvider value, child) {
                          return value.isHourlyLoading == false
                              ? Shimmer(
                                  gradient: _shimmerGradient,
                                  child: ListView.builder(
                                    itemCount: weatherDataImage.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        width: 20.w,
                                        height: 8.h,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey.shade50,
                                            borderRadius:
                                                BorderRadius.circular(5.w)),
                                      );
                                    },
                                  ))
                              : ListView.builder(
                                  itemCount: 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      width: 20.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(5.w),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                              "https://openweathermap.org/img/wn/${value.hresponse.list![index].weather![0].icon!}@2x.png"),
                                          Text(
                                            value.isHourlyLoading == false
                                                ? ""
                                                : "${(((value.hresponse.list![index].main!.temp!)).toStringAsFixed(1))}°C",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "${value.hresponse.list![index].dtTxt.toString().split(" ").last.toString().substring(0, 5)}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 80.w,
                      height: 4.h,
                      child: Text(
                        "Today",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Consumer(
                      builder: (context, WeatherProvider value, child) {
                        return Container(
                          width: 80.w,
                          height: 9.5.h,
                          decoration: BoxDecoration(
                              color: Color(0xff1500ff).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(3.w)),
                          child: Row(
                            children: [
                              Image.network(
                                  "https://openweathermap.org/img/wn/${value.response.weather![0].icon!}@2x.png"),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: 50.w,
                                    height: 4.h,
                                    //  value.hresponse.list![index]
                                    // .weather![0].main
                                    child: Text(
                                      value.hresponse.list![0].weather![0].main
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 50.w,
                                    height: 4.2.h,
                                    child: Text(
                                      "Jangan lupa bawa payung ya",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Consumer(
                      builder: (context, WeatherProvider value, child) {
                        return value.isDailyLoading == false
                            ? Center(
                                child: Container(
                                  child: Text(
                                    "LOADİNG",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.zero,
                                width: 75.w,
                                height: 24.h,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: weatherDataClock.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: 80.w,
                                      height: 7.3.h,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade900
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 10.w,
                                                height: 10.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade200,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: value.isDailyLoading ==
                                                        true
                                                    ? Image.network(
                                                        "https://openweathermap.org/img/wn/${value.hresponse.list![index].weather![0].icon!}@2x.png")
                                                    : Text("null")),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          SizedBox(
                                            width: 45.w,
                                            height: 30.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  value.hresponse.list![index]
                                                      .weather![0].main
                                                      .toString()
                                                      .split(" ")
                                                      .last
                                                      .toString()
                                                      .substring(9),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                SizedBox(
                                                  height: 0.6.h,
                                                ),
                                                Text(
                                                  value.hresponse.list![index]
                                                      .weather![0].description
                                                      .toString()
                                                      .split(" ")
                                                      .last
                                                      .toString()
                                                      .substring(
                                                        12,
                                                      ),
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          //
                                          //
                                          //
                                          Text(
                                            "${(((value.hresponse.list![index].main!.tempMax!)).toStringAsFixed(1))}°C",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          weatherDetailScreen(),
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> AlertMessage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Lütfen Geçerli Bir Değer Giriniz"),
              content: const Text("Şehir Alanı Boş Olamaz!"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Tamam"),
                ),
              ],
            ));
  }
}

LinearGradient _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Colors.blueGrey.shade50,
    Colors.blueGrey.shade200,
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.repeated,
);

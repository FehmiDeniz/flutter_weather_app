import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather_myapp/animation/animation.dart';
import 'package:weather_myapp/models/hovercast_reader.dart';
import 'package:weather_myapp/provider/weather_provider.dart';

class weatherDetailScreen extends StatefulWidget {
  weatherDetailScreen({super.key});

  @override
  State<weatherDetailScreen> createState() => _weatherDetailScreenState();
}

class _weatherDetailScreenState extends State<weatherDetailScreen> {
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

  List<String> gridImage = [
    "assets/im_grid1.png",
    "assets/im_grid2.png",
    "assets/im_grid3.png",
    "assets/im_grid4.png",
  ];

  List<String> gridText1 = ["86%", "940 hPa", "1km/h", "14%"];
  List<String> gridText2 = [
    "Kelembaban",
    "Tekanan Udara",
    "Kecepatan Angin",
    "Kabut"
  ];

  late AnimationController animateController;
  WeatherProvider? hovercastReader;
  @override
  void initState() {
    super.initState();

    hovercastReader = Provider.of<WeatherProvider>(
      context,
      listen: false,
    );
  }

  String datetime = DateTime.now().toString();
  String hourData = DateFormat("HH:mm a").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, WeatherProvider value, child) {
                  return Container(
                    width: 100.w,
                    height: 41.h,
                    color: Color(0xff4F7FFA),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 15, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                    size: 35,
                                    color: Colors.white,
                                  )),
                              Text(
                                "${hovercastReader?.hresponse.city!.name} / ${hovercastReader!.hresponse.city!.country}",
                                // ${widget.city.replaceFirst("a", "A")}

                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$datetime",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            Text(
                              "",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ],
                        ),
                        FaIcon(
                          FontAwesomeIcons.cloudSunRain,
                          color: Colors.white,
                          size: 20.w,
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          child: animationScreen(),
                        ),
                        Text(
                          "${hovercastReader!.response.main!.temp}°C",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "${hovercastReader?.response.weather?[0].main}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Terakhir update 3.00 PM",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.refresh,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.w,
                      height: 5.h,
                      child: Text(
                        "Cuaca Per Jam",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 15.h,
                      child: ListView.builder(
                        itemCount: weatherDataImage.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            width: 20.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  weatherDataImage[index],
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "${weatherDataTemperature[index]}°",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(weatherDataClock[index]),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      width: 100.w,
                      height: 5.h,
                      child: const Text(
                        "Detail Informasi",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 94.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 4.0,
                              percent: 0.2,
                              center: const Text(
                                "12",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: Colors.green,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: 60.w,
                                    height: 3.h,
                                    child: Text(
                                      "AQI - Sangat Baik",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )),
                                Container(
                                    width: 60.w,
                                    height: 10.h,
                                    child: Text(
                                        "Kualitas udara di daerahmu untuk saat ini sangat baik. Tidak ada pencemaran udara yang menyebabkan berbagai penyakit.")),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: 100.w,
                        height: 15.h,
                        padding: EdgeInsets.all(12.0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: gridImage.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 4 / 1,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    gridImage[index],
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        gridText1[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(gridText2[index])
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:weather_myapp/screens/weather_details.dart';

class animationScreen extends StatefulWidget {
  const animationScreen({super.key});

  @override
  State<animationScreen> createState() => _animationScreenState();
}

class _animationScreenState extends State<animationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController fdbcontroller;

  @override
  void initState() {
    super.initState();
    fdbcontroller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    fdbcontroller.forward();

    fdbcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fdbcontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        fdbcontroller.forward();
      }
    });
  }

  @override
  void dispose() {
    fdbcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fdbcontroller.view,
      builder: (context, child) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 10; i++)
                Transform.translate(
                  offset:
                      Offset(0, fdbcontroller.value * Random().nextInt(200)),
                  child: ColorMethod(),
                )
            ],
          ),
        );
      },
    );
  }
}

class ColorMethod extends StatelessWidget {
  ColorMethod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(width: 50, height: 50, color: renk);
    return SizedBox(
        width: 10,
        height: 10,
        child: Image.asset(
          "assets/rain.png",
          fit: BoxFit.cover,
        ));
  }
}

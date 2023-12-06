import 'package:flutter/material.dart';
import 'package:home_work/screens/daily_screen.dart';
import 'package:home_work/screens/explore_screen.dart';
import 'package:home_work/screens/home_screen/home_screen.dart';
import 'package:home_work/screens/time_line_creen.dart';

class Screens {
  static Map<String, Widget> screens = {
    'Home': const HomeScreen(),
    'Daily': const DailyScreen(),
    'TimeLine': const TimeLineScreen(),
    'Explore': const ExploreScreen(),
  };
}

import 'package:flutter/material.dart';
import '../components/bottom_navigation.dart';
import '../screens/other/get_started.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("MyData");
    final bool isLoggedIn = box.get('name') != null && box.get('email') != null;

    return MaterialApp(
      title: 'WatchWise',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? BottomNavigation(currentIndex: 0,) : GetStarted(),
    );
  }
}

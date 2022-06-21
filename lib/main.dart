import 'package:flutter/material.dart';
import 'package:gambling/app/ui/bottom_navigation.dart';
import 'package:gambling/app/ui/gambling_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          body: GablingMain(),
          bottomNavigationBar: GambleBottomNavigation(),
        ),
      ),
    );
  }
}
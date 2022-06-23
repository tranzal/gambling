import 'package:flutter/material.dart';
import 'package:gambling/app/provider/participant_provider.dart';
import 'package:gambling/app/ui/gambling_page.dart';
import 'package:gambling/app/ui/participant_page.dart';
import 'package:gambling/app/ui/setting_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ParticipantProvider(),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
  )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _widgetOptions =const <Widget>[
    GamblingPage(),
    ParticipantPage(),
    SettingPage()
  ];
  int _selectIndex = 0;

  void _bottomNavigationTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,

        child: Scaffold(
          body: _widgetOptions.elementAt(_selectIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.casino),
                label: '배팅',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                label: '인원추가',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '설정',
              )
            ],
            currentIndex: _selectIndex,
            selectedItemColor: Colors.blue,
            onTap: _bottomNavigationTap,
          ),
        ),
    );
  }
}

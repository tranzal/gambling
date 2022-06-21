import 'package:flutter/material.dart';

class GambleBottomNavigation extends StatelessWidget {
  const GambleBottomNavigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
        ]
    );
  }
}

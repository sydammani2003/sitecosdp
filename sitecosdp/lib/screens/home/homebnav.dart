import 'package:flutter/material.dart';
import 'package:sitecosdp/screens/home/homeprofile.dart';
import 'package:sitecosdp/screens/home/homesiteco.dart';

class Homebnav extends StatefulWidget {
  const Homebnav({super.key});

  @override
  State<Homebnav> createState() => _HomebnavState();
}

class _HomebnavState extends State<Homebnav> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Homesiteco(), Homeprofile()];

  final List<String> _titles = ['Home', 'User'];

  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.person_rounded,
  ];

  final List<Color> _colors = [
    Color(0xFF2E073F),
    Color(0xFF7A1CAC),
    Color(0xFFAD49E1),
    Color(0xFFEBD3F8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors[3],
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _colors[1],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: _colors[0],
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: List.generate(
            _titles.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(_icons[index]),
              label: _titles[index],
            ),
          ),
        ),
      ),
    );
  }
}

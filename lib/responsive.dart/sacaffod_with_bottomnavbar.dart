import 'package:flutter/material.dart';

import 'package:sikshya/Navigation_bar/courses.dart';
import 'package:sikshya/Navigation_bar/dashboard_screen.dart';
import 'package:sikshya/Navigation_bar/Profile/profile_screen.dart';

class ScaffoldWithBottomNavbar extends StatefulWidget {
  final int initialIndex;

  ScaffoldWithBottomNavbar({this.initialIndex = 0});

  @override
  _ScaffoldWithBottomNavbarState createState() =>
      _ScaffoldWithBottomNavbarState();
}

class _ScaffoldWithBottomNavbarState extends State<ScaffoldWithBottomNavbar> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          DashboardScreen(
            pageController: _pageController,
          ),
          CoursesNav(),
          ProfileScreen(),
          //DashboardScreen(pageController: _pageController),
          // Categories(pageController: _pageController),
          // PlantScanner(pageController: _pageController),
          // Profile(pageController: _pageController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

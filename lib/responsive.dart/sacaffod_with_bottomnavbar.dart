import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart'; // For navigation to chat screen
import 'package:go_router/go_router.dart';
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/cubit/buy_courses/buy_courses_cubit.dart';
import 'package:sikshya/services/api_services.dart';
import 'package:sikshya/user/Navigation_bar/Profile/profile_screen.dart';
import 'package:sikshya/user/Navigation_bar/dashboard_screen.dart';
import 'package:sikshya/user/my_course.dart'; // For GoRouter navigation

class ScaffoldWithBottomNavbar extends StatefulWidget {
  const ScaffoldWithBottomNavbar({super.key, required this.child});
  final Widget child;

  @override
  _ScaffoldWithBottomNavbarState createState() =>
      _ScaffoldWithBottomNavbarState();
}

class _ScaffoldWithBottomNavbarState extends State<ScaffoldWithBottomNavbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyCoursesCubit(locator.get<ApiService>()),
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF1B9527),
          unselectedItemColor: const Color(0xFF706060),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'My Courses', // Updated: Courses instead of Categories
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _onItemTapped(context, index);
          },
        ),

        // ),
      ),
    );
  }

  // Handles navigation when a BottomNavigationBar item is tapped
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(DashboardScreen.routeName); // Navigates to Dashboard
        break;
      case 1:
        context.goNamed(MyCourse.routeName); // Navigates to Courses (Updated)
        break;

      case 2:
        context.goNamed(ProfileScreen.routeName); // Navigates to Profile
        break;
      default:
        break;
    }
  }
}

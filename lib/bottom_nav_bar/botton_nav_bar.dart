// import 'package:flutter/material.dart';
// import 'package:sikshya/bottom_nav_bar/courses.dart'; // Import CourseScreen
// import 'package:sikshya/bottom_nav_bar/dashboard_screen.dart';
// import 'package:sikshya/bottom_nav_bar/profile_screen.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({Key? key, required int selectedIndex}) : super(key: key);

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;

//       // Navigate based on selected index
//       switch (index) {
//         case 0:
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => (pa)),
//           );
//           break;
//         case 1:
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CoursesNav()),
//           );
//           break;
//         case 2:
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ProfileScreen()),
//           );
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Colors.lightBlueAccent,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.white,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.book),
//           label: 'Courses',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//     );
//   }
// }

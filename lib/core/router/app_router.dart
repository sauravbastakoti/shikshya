import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sikshya/service/dashboard_services.dart';
import 'package:sikshya/user/Navigation_bar/Profile/profile_screen.dart';
import 'package:sikshya/user/Navigation_bar/dashboard_screen.dart';
import 'package:sikshya/Splash_screen/splash_screen.dart';
import 'package:sikshya/features/login_screen.dart';
import 'package:sikshya/responsive.dart/sacaffod_with_bottomnavbar.dart';
import 'package:sikshya/user/my_course.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      // Uncomment this if you want to add a registration page later
      // GoRoute(
      //   name: RegisterScreen.routeName,
      //   path: '/register',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const RegisterScreen();
      //   },
      // ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavbar(
            child: child, // This will be the content for the current tab
          );
        },
        routes: [
          GoRoute(
            name: DashboardScreen.routeName,
            path: '/dashboard',
            builder: (context, state) {
              return DashboardScreen(pageController: PageController());
            },
          ),
          GoRoute(
            name: MyCourse.routeName,
            path: '/mycourses',
            builder: (context, state) {
              return MyCourse(pageController: PageController());
            },
          ),
          GoRoute(
            name: ProfileScreen.routeName,
            path: '/profile',
            builder: (context, state) {
              return ProfileScreen(
                pageController: PageController(),
              );
            },
          ),
        ],
      ),
    ],
  );
}

import 'dart:io'; // Import for HttpOverrides
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart'; // If using video_player package
import 'package:sikshya/core/router/app_router.dart';

import 'package:sikshya/core/shared_prefences/counter_bloc.dart';
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences service
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();

  // Set up Bloc observer
  Bloc.observer = const CounterObserver();

  // Set up dependency injection
  await setUpLocator();

  // Override SSL certificate verification for development (Don't use in production!)
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

// HttpOverrides class to bypass SSL certificate validation
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router, // Use go_router for routing
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Components/ssl_http_client.dart';

import 'PresentationLayer/Pages/splash_screen.dart';

void main() {
  // ColorOS 13 / some Android 13 OEM builds lack Sectigo Root R46 used by the API.
  HttpOverrides.global = InfoInstallHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with PrintMixin {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Set the color of the back button to white
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Demo(),
      home: const SplashScreen(),
    );
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider<SimListBloc>(
    //       create: (context) => SimListBloc(), // Initialize CheckOutBloc here
    //     ),
    //     BlocProvider<CheckOutBloc>(
    //       create: (context) => CheckOutBloc(), // Initialize CheckOutBloc here
    //     ),
    //     BlocProvider<RemoveDeviceBloc>(
    //       create: (context) =>
    //           RemoveDeviceBloc(), // Initialize RemoveDeviceBloc here
    //     ),
    //   ],
    //   child:MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     appBarTheme: const AppBarTheme(
    //       iconTheme: IconThemeData(
    //         color: Colors.white, // Set the color of the back button to white
    //       ),
    //     ),
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   // home: Demo(),
    //   home: const SplashScreen(),
    // ),
    // );
  }
}

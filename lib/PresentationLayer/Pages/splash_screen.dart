import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infoinstall/PresentationLayer/Components/constant.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Pages/dashboard_screen.dart';
import 'package:infoinstall/PresentationLayer/Pages/login_screen.dart';
import '../Bloc/Blocs/login_bloc.dart';
// import 'package:workmanager/workmanager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with PrintMixin {
  final storage = const FlutterSecureStorage();
  // late Box box1;
  @override
  void initState() {
    super.initState();
    // initWorkManagerAndTasks();
    navigateTo();
  }

  // void initWorkManagerAndTasks() async {
  //   // Initialize Workmanager
  //   await Workmanager().initialize(
  //     callbackDispatcher,
  //     isInDebugMode: true,
  //   );

  //   // Register your tasks
  //   registerPeriodicTasks();
  // }

  // void registerPeriodicTasks() {
  //   const taskId = "simplePeriodicTask";

  //   // Cancel the task if it might already be registered
  //   Workmanager().cancelByUniqueName(taskId).then((_) {
  //     // Register the task again
  //     Workmanager().registerPeriodicTask(
  //       taskId,
  //       taskId,
  //       frequency: const Duration(minutes: 10),
  //       initialDelay: const Duration(seconds: 0),
  //     );

  //     p('Task $taskId has been re-registered');
  //   }).catchError((error) {
  //     p('Error canceling old task: $error');
  //   });
  // }

  // @pragma('vm:entry-point')
  // void callbackDispatcher() {
  //   Workmanager().executeTask((task, inputData) async {
  //     p("Executing background task: $task");

  //     try {
  //       // Check location service permission
  //       LocationPermission permission = await Geolocator.checkPermission();
  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //         if (permission == LocationPermission.denied) {
  //           p("Location permission denied");
  //           return Future.value(false); // Exit if permission denied
  //         }
  //       }

  //       if (permission == LocationPermission.deniedForever) {
  //         // Permissions are denied forever, handle appropriately.
  //         p("Location permissions are permanently denied");
  //         return Future.value(false);
  //       }

  //       // Get the current position
  //       Position position = await Geolocator.getCurrentPosition();
  //       p("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

  //       await storage.write(key: 'Latitude', value: '${position.latitude}');
  //       await storage.write(key: 'Longitude', value: '${position.longitude}');
  //     } catch (e) {
  //       p("Failed to get location: $e");
  //       return Future.value(false);
  //     }

  //     return Future.value(true);
  //   });
  // }

  navigateTo() async {
    // getdata();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      String? isLoggedIn = await storage.read(key: isLogin);
      String? userId = await storage.read(key: kUSERID);
      String? id = await storage.read(key: kID);

      if (isLoggedIn != null && isLoggedIn.contains('1')) {
        p('islogin in splash : $isLoggedIn');
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              userId: int.parse(userId!),
              id: int.parse(id!),
            ),
          ),
        );
      } else {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginPage(),
            ),
          ),
        );
      }
      // if (DBConstant.isFirstTime != null) {
      //   if (DBConstant.isLoggedIn != null) {
      // if (DBConstant.isLoggedIn!) {
      //   Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   ),
      //   );
      // } else {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //         create: (context) => LoginBloc(),
      //         child: const LoginPage(),
      //       ),
      //     ),
      //   );
      // }
      //   } else {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => BlocProvider(
      //           create: (context) => LoginBloc(),
      //           child: const LoginPage(),
      //         ),
      //       ),
      //     );
      //   }
      // } else {
      //   // Navigator.of(context).pushReplacement(
      //   //   MaterialPageRoute(
      //   //     builder: (context) => const OnboardScreen(),
      //   //   ),
      //   // );

      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //         create: (context) => LoginBloc(),
      //         child: const LoginPage(),
      //       ),
      //     ),
      //   );

      //   // Navigator.pushReplacement(
      //   //   context,
      //   //   MaterialPageRoute(
      //   //     builder: (context) => ClientListScreen(
      //   //       title: "CLIENT LIST",
      //   //     ),
      //   //   ),
      //   // );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: size.height * 0.5,
          width: size.width * 0.5,
          child: Image.asset(
            'assets/images/ic_infoinsatll_trans.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

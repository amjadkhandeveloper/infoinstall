import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infoinstall/DomainLayer/Entities/logout_entity.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/client_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/job_summary_bloc.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';
import 'package:infoinstall/PresentationLayer/Components/constant.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Components/toast_message.dart';
import 'package:infoinstall/PresentationLayer/Pages/splash_screen.dart';
import 'package:intl/intl.dart';

import '../Bloc/Blocs/login_bloc.dart';
import '../Bloc/Events/login_event.dart';
import '../Bloc/States/login_state.dart';
import '../Pages/client_list_screen.dart';
import '../Pages/installer_list_screen.dart';
import '../Pages/job_summary_screen.dart';
import '../Pages/profile_screen.dart';

class AppDrawer extends StatefulWidget {
  final int userId;
  final int id;
  const AppDrawer({required this.userId, required this.id, super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with PrintMixin {
  late LoginBloc loginBloc;
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    // Initialize the CheckOutBloc here
    loginBloc =
        LoginBloc(); // Modify this according to your CheckOutBloc initialization logic
  }

  @override
  void dispose() {
    loginBloc.close(); // Close the bloc when disposing the screen
    super.dispose();
  }

  void setData() async {
    await storage.write(
      key: isLogin,
      value: '0.0',
    );
    await storage.write(
      key: kUSERID,
      value: "0",
    );
    await storage.write(
      key: kID,
      value: "0",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) async {
        p('state listner block app bar');
        if (state is LogoutLoaded) {
          setData();
          customToast(
            message: "Logout successful",
            color: Colors.green,
          );
          p('Logout ${state.status}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            ),
          );
        }
      },
      child: Drawer(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeaderWidget(),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('DASHBOARD'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('PROFILE'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(userId: widget.userId),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.summarize),
                  title: const Text('TODAY\'s SUMMARY'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => JobSummaryBloc(),
                          child: JobSummaryScreen(
                            userId: widget.userId,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('CLIENT LIST'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ClientBloc(),
                          child: const ClientListScreen(
                            title: 'CLIENT LIST',
                            clientId: "0",
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.list_alt),
                  title: const Text('EMPLOYEE LIST'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstallerListScreen(
                          title: 'EMPLOYEE LIST',
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('LOGOUT'),
                  onTap: () {
                    // Handle logout
                    String formattedDate =
                        DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'")
                            .format(DateTime.now());
                    LogoutRequest loginRequest = LogoutRequest(
                      userLogoutTimeline: UserLogoutTimeline(
                        id: widget.id,
                        userId: widget.userId,
                        logoutTime: formattedDate,
                        loginlat: 0.0,
                        loginlon: 0.0,
                        logoutlat: 0.0,
                        logoutlon: 0.0,
                        distance: 0,
                        travelTime: "",
                        batteryStatus: 100,
                        deviceName: "",
                        deviceModel: "",
                        cUserId: 0,
                      ),
                      insertMode: 1,
                    );

                    loginBloc.add(
                      DoLogout(
                        logoutRequest: loginRequest,
                      ),
                    );
                  },
                ),
                const Divider(),
              ],
            ),
          ],
        ),
        // },
        // ),
      ),
    );
  }
}

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: const Text(
        'Infoinstall V2',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      accountEmail: const Text(
        'App Version : $versionCode\n$versionDate',
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      currentAccountPicture: Container(
        color: Colors.white, // Set the background color to white
        child: Image.asset(
          'assets/images/ic_infoinsatll_trans.png',
        ),
      ),
      decoration: const BoxDecoration(
        color: ColorsPlatte.accentColor,
      ),
    );
  }
}

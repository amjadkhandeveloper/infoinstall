import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/dashboard_count_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/job_list_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/dashboard_count_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/dashobard_count_state.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import '../Bloc/Blocs/login_bloc.dart';
import '../Components/color_plattes.dart';
import '../Components/constant.dart';
import '../Widgets/dashboard_card.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../DataLayer/Model/dashbaord_item.dart';
import '../Widgets/drawer_widget.dart';
import 'job_list_screen.dart';

final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

class DashboardScreen extends StatefulWidget {
  final int userId;
  final int id;
  const DashboardScreen({Key? key, required this.userId, required this.id})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with PrintMixin {
  late DashboardCountBloc _dashboardCountBloc; // Declare the ClientBloc
  // Get the current date
  // DateTime now = DateTime.now();
// Output will be something like "2024-03-21"
  final storage = const FlutterSecureStorage();
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late bool result = true;

  @override
  void initState() {
    super.initState();
    // initConnectivity();
    // Format the date
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus)
    //         as StreamSubscription<ConnectivityResult>;
    setData();
    // Print the formatted date
    Logger(formattedDate);
    _dashboardCountBloc = DashboardCountBloc(); // Initialize the ClientBloc
    _dashboardCountBloc.add(FetchDashboardCount(
      currentDate: formattedDate,
      userID: widget.userId,
    )); // Trigger the FetchClient event
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initConnectivity() async {
  //   List<ConnectivityResult> result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     p('Couldn\'t check connectivity status: $e');
  //     return;
  //   }
  //   return _updateConnectionStatus(result);
  // }

  // void _updateConnectionStatus(List<ConnectivityResult> result) {
  //   setState(() {
  //     if (result.isNotEmpty) _connectionStatus = result[0];
  //   });
  // }

  void setData() async {
    await storage.write(
      key: kUSERID,
      value: widget.userId.toString(),
    );
    await storage.write(
      key: kID,
      value: widget.id.toString(),
    );
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnection().hasInternetAccess;
    setState(() {}); // Update UI on change
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    _dashboardCountBloc.close(); // Close the bloc when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DASHBOARD",
          style: TextStyle(color: ColorsPlatte.lightgreenshede),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await checkInternetConnection();
              _dashboardCountBloc.add(FetchDashboardCount(
                currentDate: formattedDate,
                userID: widget.userId,
              ));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          ),
        ],
        backgroundColor: ColorsPlatte.accentColor,
      ),
      backgroundColor: Colors.grey[200],
      drawer: BlocProvider(
        create: (context) => LoginBloc(),
        child: AppDrawer(userId: widget.userId, id: widget.id),
      ), // Add the Drawer here
      body: //_connectionStatus != ConnectivityResult.none
          result
              ? BlocBuilder<DashboardCountBloc, DashboardCountState>(
                  bloc: _dashboardCountBloc,
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await checkInternetConnection();
                        _dashboardCountBloc.add(FetchDashboardCount(
                          currentDate: formattedDate,
                          userID: widget.userId,
                        ));
                      },
                      child: _buildDashboardContent(context, state),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'No internet connection!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await checkInternetConnection();
                          _dashboardCountBloc.add(FetchDashboardCount(
                            currentDate: formattedDate,
                            userID: widget.userId,
                          ));
                        },
                        //initConnectivity(),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildDashboardContent(
      BuildContext context, DashboardCountState state) {
    if (state is DashboardCountLoading) {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is DashboardCountLoaded) {
      List<DashboardData> dashboardCardList = [
        DashboardData(
          icon: Image.asset('assets/images/icons/ic_pending.png'),
          count: (state.dashboardCountDetailsModel[0].cnt +
              state.dashboardCountDetailsModel[1].cnt +
              state.dashboardCountDetailsModel[3].cnt),
          title: 'PENDING',
          description: 'ITL, QAT, Cholla',
          colorCode: Colors.amber[700],
        ),
        DashboardData(
          icon: Image.asset('assets/images/icons/ic_inprogress.png'),
          count: (state.dashboardCountDetailsModel[2].cnt +
              state.dashboardCountDetailsModel[4].cnt +
              state.dashboardCountDetailsModel[5].cnt),
          title: 'INPROGRESS',
          description: 'Description 3',
          colorCode: Colors.yellow[700],
        ),
        DashboardData(
          icon: Image.asset('assets/images/icons/ic_completed.png'),
          count: (state.dashboardCountDetailsModel[6].cnt +
              state.dashboardCountDetailsModel[8].cnt),
          title: 'COMPLETED',
          description: 'QAT',
          colorCode: Colors.green[700],
        ),
        DashboardData(
          icon: Image.asset('assets/images/icons/ic_cancel.png'),
          count: state.dashboardCountDetailsModel[7].cnt,
          title: 'CANCELLED',
          description: 'QAT',
          colorCode: Colors.red[700],
        ),
      ];

      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Text(
                    'JOB STATUS DETAILS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // chartList.isEmpty
                //     ? Container()
                //     : Center(
                //         child: SfCircularChart(
                //           margin: const EdgeInsets.all(0.0),
                //           series: <CircularSeries>[
                //             PieSeries<DashboardData, String>(
                //               dataSource: chartList,
                //               pointColorMapper: (DashboardData data, _) =>
                //                   data.colorCode,
                //               xValueMapper: (DashboardData data, _) =>
                //                   data.title,
                //               yValueMapper: (DashboardData data, _) =>
                //                   data.count,
                //               dataLabelMapper:
                //                   (DashboardData data, int index) => data.title,
                //               radius: '40%',
                //               explode: true,
                //               explodeIndex: 0,
                //               // startAngle: 270,
                //               // endAngle: 90,
                //               dataLabelSettings: const DataLabelSettings(
                //                 isVisible: true,
                //                 color: Colors.black,
                //                 overflowMode: OverflowMode.shift,
                //                 labelAlignment: ChartDataLabelAlignment.outer,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
              ],
            ),
            Column(
              children: dashboardCardList.map(
                (data) {
                  return GestureDetector(
                    onTap: () {
                      // Format the date
                      int type = dashboardCardList.indexOf(data) + 1;
                      int jobStatus = 0;
                      if (type == 1) {
                        jobStatus = 1; // 1, 2, 4
                      } else if (type == 2) {
                        jobStatus = 3; // 3, 5, 6
                      } else if (type == 3) {
                        jobStatus = 7; // 7 and 9
                      } else if (type == 4) {
                        jobStatus = 8; // 8
                      }
                      // Handle press event for each card
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => JobListBloc(),
                            child: JobListScreen(
                              type: type,
                              title: '${data.title.toUpperCase()} JOBS',
                              currentDate: formattedDate,
                              jobStatus: jobStatus,
                              userId: widget.userId,
                            ),
                          ),
                        ),
                      ).then((_) {
                        _dashboardCountBloc.add(FetchDashboardCount(
                          currentDate: formattedDate,
                          userID: widget.userId,
                        ));
                      });
                    },
                    child: DashboardCard(
                      dashboardData: data,
                      cardColor: ColorsPlatte.getColor(
                          dashboardCardList.indexOf(data)),
                      iconColor: ColorsPlatte.lightgreenshede,
                    ),
                  );
                },
              ).toList(),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            //   child: Text(
            //     'JOB STATUS',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      );

      // return Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Padding(
      //       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      //       child: Text(
      //         'JOB STATUS DETAILS',
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //     GridView.builder(
      //       shrinkWrap:
      //           true, // This will make the GridView take up only as much space as it needs
      //       // physics:
      //       //     NeverScrollableScrollPhysics(), // Essential to disable GridView's own scrolling to prevent it from trying to scroll inside the SingleChildScrollView
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2, // Number of columns
      //         crossAxisSpacing: 8, // Horizontal space between cards
      //         mainAxisSpacing: 8, // Vertical space between cards
      //       ),
      //       itemCount: dashboardCardList.length, // Total number of cards
      //       itemBuilder: (context, index) {
      //         var data = dashboardCardList[index];
      //         return GestureDetector(
      //           onTap: () {
      //             // Format the date
      //             int type = index + 1;
      //             int jobStatus = 0;
      //             if (type == 1) {
      //               jobStatus = 1; // 1, 2, 4
      //             } else if (type == 2) {
      //               jobStatus = 3; // 3, 5, 6
      //             } else if (type == 3) {
      //               jobStatus = 7; // 7 and 9
      //             } else if (type == 4) {
      //               jobStatus = 8; // 8
      //             }
      //             // Handle press event for each card
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => JobListScreen(
      //                   type: type,
      //                   title: '${data.title.toUpperCase()} JOBS',
      //                   currentDate: formattedDate,
      //                   jobStatus: jobStatus,
      //                   userId: widget.userId,
      //                 ),
      //               ),
      //             ).then((_) {
      //               _dashboardCountBloc.add(FetchDashboardCount(
      //                 currentDate: formattedDate,
      //                 userID: widget.userId,
      //               ));
      //             });
      //           },
      //           child: DashboardCard(
      //             dashboardData: data,
      //             cardColor: ColorsPlatte.getColor(index),
      //             iconColor: ColorsPlatte.lightgreenshede,
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // );
    } else if (state is DashboardCountError) {
      return Center(child: Text(state.errorMessage));
    } else {
      return const Center(child: Text('Please wait'));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/job_summary_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/job_summary_event.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';

import '../Bloc/States/job_summary_state.dart';
import '../Components/color_plattes.dart';
import '../Widgets/app_bar_widget.dart';

class JobSummaryScreen extends StatefulWidget {
  final int userId;
  const JobSummaryScreen({super.key, required this.userId});

  @override
  State<JobSummaryScreen> createState() => _JobSummaryScreenState();
}

class _JobSummaryScreenState extends State<JobSummaryScreen> with PrintMixin {
  late JobSummaryBloc jobSummaryBloc;
  final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int countOfJobs = 0;
  late bool result = true;

  @override
  void initState() {
    super.initState();
    jobSummaryBloc = JobSummaryBloc();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnection().hasInternetAccess;
    if (result) {
      jobSummaryBloc.add(
          FetchJobSummary(currentDate: formattedDate, userID: widget.userId));
    }
    setState(() {}); // Update UI on change
  }

  @override
  void dispose() {
    jobSummaryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(heading: 'TODAY JOB SUMMARY'),
      body: BlocBuilder<JobSummaryBloc, JobSummaryState>(
        bloc: jobSummaryBloc,
        builder: (context, state) {
          if (state is JobSummaryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JobSummaryLoaded) {
            if (result) {
              // Creating Map<String, int> data
              Map<String, int> data = {};
              for (var job in state.jobSummaryDetailsModel) {
                data[job.jobStatus] = job.cnt;
                countOfJobs += job.cnt;
              }
              p('Jobs count in Summary $countOfJobs');
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // countOfJobs > 0
                    //     ? Expanded(
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: PieChart(
                    //             PieChartData(
                    //               sections: List.generate(
                    //                 data.length,
                    //                 (index) => PieChartSectionData(
                    //                   color: ColorsPlatte.getJobColor(index),
                    //                   value:
                    //                       data.values.elementAt(index).toDouble(),
                    //                   title: '${data.values.elementAt(index)}',
                    //                   radius: 90,
                    //                 ),
                    //               ),
                    //               sectionsSpace: 0,
                    //               centerSpaceRadius: 30,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : Container(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Text(
                            'JOB STATUS',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Text(
                            'COUNT',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Divider(),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = data.keys.elementAt(index);
                          int value = data.values.elementAt(index);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListTile(
                              leading: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: ColorsPlatte.getJobColor(index),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: Text(
                                key,
                                style: const TextStyle(fontSize: 16),
                              ),
                              trailing: Text(
                                '$value',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.grey[400],
                            height: 0,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
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
                      },
                      //initConnectivity(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
          } else {
            if (result) {
              return const Center(
                child: Text('Please wait'),
              );
            } else {
              return Center(
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
                      },
                      //initConnectivity(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}

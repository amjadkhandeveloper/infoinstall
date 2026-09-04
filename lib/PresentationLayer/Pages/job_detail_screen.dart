import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infoinstall/DataLayer/Model/job_status_model.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/job_status_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/device_list_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/jobstatus_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/jobstatus_status.dart';
import 'package:infoinstall/PresentationLayer/Components/constant.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Components/toast_message.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../DataLayer/Model/job_list_item_model.dart';
import '../Bloc/Blocs/device_list_bloc.dart';
import '../Bloc/States/device_list_state.dart';
import '../Components/color_plattes.dart';
import '../Widgets/device_list_item_widget.dart';

import 'package:flutter/foundation.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobListDetailsModel jobDetails;

  const JobDetailsScreen({Key? key, required this.jobDetails})
      : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> with PrintMixin {
  late DeviceListBloc _deviceListBloc; // Declare the ClientBloc
  late JobStatusBloc _jobStatusBloc;
  double lat = 0.0;
  double lon = 0.0;

  void fetchData() {
    _jobStatusBloc = JobStatusBloc();
    _deviceListBloc = DeviceListBloc(); // Initialize the ClientBloc
    _deviceListBloc.add(FetchDeviceList(
      jobID: widget.jobDetails.jobId.toString(),
      userID: widget.jobDetails.userId.toString(),
    )); // Trigger the FetchClient event
  }

  void updateLatLon() async {
    const storage = FlutterSecureStorage();
    try {
      // Check location service permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          p("Location permission denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        p("Location permissions are permanently denied");
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition();
      p("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

      await storage.write(key: 'Latitude', value: '${position.latitude}');
      await storage.write(key: 'Longitude', value: '${position.longitude}');
    } catch (e) {
      p("Failed to get location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    updateLatLon();
  }

  void getLatLon() async {
    const storage = FlutterSecureStorage();
    lat = double.parse(await storage.read(key: isLogin) ?? "0.0");
    lon = double.parse(await storage.read(key: kUSERID) ?? "0.0");
  }

  @override
  void dispose() {
    _jobStatusBloc.close();
    _deviceListBloc.close(); // Close the bloc when not needed
    super.dispose();
  }

  // ignore: unused_element
  Future<void> _launchInBrowser(String url) async {
    if (kDebugMode) {
      p('Chat url : $url');
    }

    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    getLatLon();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JOB DETAILS",
          style: TextStyle(color: ColorsPlatte.lightgreenshede),
        ),
        backgroundColor: ColorsPlatte.accentColor,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Job ID: ${widget.jobDetails.jobId ?? 'N/A'}',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: FloatingActionButton(
                  //     onPressed: () async {
                  //       String url =
                  //           'https://iftwebrtc.infotracktelematics.com:999/#/chat;roomId=test;userName=${widget.jobDetails.employeename};userType=employee;userId=${widget.jobDetails.userId};appName=infoinstall';
                  //       _launchInBrowser(url);
                  //     },
                  //     child: const Icon(Icons.video_call),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              _buildDetailRow('Employee Name', widget.jobDetails.employeename),
              _buildDetailRow('Client Name', widget.jobDetails.clientName),
              _buildDetailRow('Job Status', widget.jobDetails.jobStatus),
              _buildDetailRow(
                  'Purpose of Visit', widget.jobDetails.purposeOfVisit),
              _buildDetailRow('Reason', widget.jobDetails.reason),
              _buildDetailRow('Job Location', widget.jobDetails.jobLocation),
              _buildDetailRow('Start Date Time',
                  '${widget.jobDetails.startDate?.split('T')[0]} ${widget.jobDetails.startTime}'),
              _buildDetailRow('End Date Time',
                  '${widget.jobDetails.endDate?.split('T')[0]} ${widget.jobDetails.endTime}'),
              const SizedBox(height: 8),
              BlocBuilder<DeviceListBloc, DeviceListState>(
                bloc: _deviceListBloc,
                builder: (context, state) {
                  if (state is DeviceListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DeviceListLoaded) {
                    widget.jobDetails.deviceList = state.deviceListDetailsModel;
                    if (state.deviceListDetailsModel.isNotEmpty) {
                      return Column(
                        children: [
                          const Center(
                            child: Text(
                              'Device List',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children:
                                state.deviceListDetailsModel.map((device) {
                              return DeviceListItemDetail(
                                context: context,
                                jobDetails: widget.jobDetails,
                                deviceListDetailsModel: device,
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else if (state is DeviceListError) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return const Center(child: Text('Please wait'));
                  }
                },
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (widget.jobDetails.jobStatusId! > 5)
                        ? Container()
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 8, bottom: 8),
                              child: MaterialButton(
                                onPressed: () async {
                                  // Add onPressed action
                                  // Your existing logic for Job Status Update...
                                  JobStatusUpdate jobStatusUpdate =
                                      JobStatusUpdate(
                                          widget.jobDetails.jobId!,
                                          widget.jobDetails.userId!,
                                          widget.jobDetails.jobStatusId!,
                                          widget.jobDetails.purposeOfVisitId ??
                                              1,
                                          lat,
                                          lon,
                                          0,
                                          0,
                                          'Updating');

                                  // final jobStatusId = getJobStatusId(
                                  //     widget.jobDetails.jobStatus.toString());
                                  p('jobid : ${widget.jobDetails.jobStatusId}');

                                  if (widget.jobDetails.jobStatusId == 0 ||
                                      widget.jobDetails.jobStatusId == 1 ||
                                      widget.jobDetails.jobStatusId == 2 ||
                                      widget.jobDetails.jobStatusId == 3 ||
                                      widget.jobDetails.jobStatusId == 4 ||
                                      widget.jobDetails.jobStatusId == 5) {
                                    jobStatusUpdate.jobStatusId = 8;
                                    p('removing the job status');

                                    removeDialog(
                                      context,
                                      UpdateJobStatus(
                                        requestString:
                                            jobStatusUpdate.toJsonString(),
                                        jobStatusId:
                                            jobStatusUpdate.jobStatusId,
                                      ),
                                    );
                                  } else {
                                    customToast(
                                      message:
                                          "You cannot decline the job. Please contact to admin",
                                      color: Colors.red,
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                },
                                color: Colors.red[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),

                                // style: ElevatedButton.styleFrom(
                                //   backgroundColor: Colors.red[
                                //       800], // Set red background color for Button 1
                                // ),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.0, right: 4.0, top: 8, bottom: 8),
                                  child: Text(
                                    'JOB DECLINE',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 8, bottom: 8),
                        child: BlocListener<JobStatusBloc, JobStatusState>(
                          bloc: _jobStatusBloc,
                          listener: (context, state) {
                            if (state is JobStatusLoaded) {
                              // Handle what happens when the job status is updated
                              if (kDebugMode) {
                                p('Handle what happens when the job status is updated');
                              }
                              if (state.jobStatusId == 8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'The job has been declined successfully'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Job status with ${getStatus(state.jobStatusId.toString())} has been updated successfully.'),
                                  ),
                                );
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else if (state is JobStatusError) {
                              // Handle error state
                              p('Handle error state');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error ${state.errorMessage}'),
                                ),
                              );
                            }
                          },
                          child: MaterialButton(
                            onPressed: () {
                              p('Handle button press');
                              // Your existing logic for Job Status Update...
                              JobStatusUpdate jobStatusUpdate = JobStatusUpdate(
                                  widget.jobDetails.jobId!,
                                  widget.jobDetails.userId!,
                                  widget.jobDetails.jobStatusId!,
                                  widget.jobDetails.purposeOfVisitId ?? 1,
                                  lat,
                                  lon,
                                  0,
                                  0,
                                  'Updating');

                              final jobStatusId = getJobStatusId(
                                  widget.jobDetails.jobStatus.toString());

                              if (jobStatusId == 0 || jobStatusId == 1) {
                                jobStatusUpdate.jobStatusId = 2;
                              } else if (jobStatusId == 2) {
                                jobStatusUpdate.jobStatusId = 3;
                              } else if (jobStatusId == 3) {
                                jobStatusUpdate.jobStatusId = 5;
                              } else if (jobStatusId == 4) {
                                jobStatusUpdate.jobStatusId = 2;
                              } else if (jobStatusId == 5) {
                                jobStatusUpdate.jobStatusId = 6;
                              } else if (jobStatusId == 6) {
                                jobStatusUpdate.jobStatusId = 7;
                              } else if (jobStatusId == 7) {
                                jobStatusUpdate.jobStatusId = 9;
                              }

                              p('updating the job status');
                              _jobStatusBloc.add(UpdateJobStatus(
                                requestString: jobStatusUpdate.toJsonString(),
                                jobStatusId: jobStatusUpdate.jobStatusId,
                              ));
                            },
                            color: getAdvanceColorStatus(
                                widget.jobDetails.jobStatusId.toString()),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: Colors.green[800],
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 8, bottom: 8),
                              child: Text(
                                getAdvanceStatus(
                                    widget.jobDetails.jobStatusId.toString()),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeDialog(
    BuildContext context,
    UpdateJobStatus updateJobStatus,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text('Decline Job'),
              content: const Text('Are you sure you want to decline the job?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Decline'),
                  onPressed: () {
                    _jobStatusBloc.add(updateJobStatus);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              textAlign: TextAlign.right,
              value ?? 'N/A',
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}

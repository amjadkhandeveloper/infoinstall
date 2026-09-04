import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/Blocs/job_list_bloc.dart';
import '../Bloc/Events/job_list_event.dart';
import '../Bloc/States/job_list_state.dart';
import '../Components/color_plattes.dart';
import '../Widgets/job_list_item_widget.dart';

class JobListScreen extends StatefulWidget {
  final int type;
  final String title;
  final String currentDate;
  final int jobStatus;
  final int userId;

  const JobListScreen({
    super.key,
    required this.type,
    required this.title,
    required this.currentDate,
    required this.jobStatus,
    required this.userId,
  });

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  late JobListBloc _jobListBloc; // Declare the ClientBloc

  @override
  void initState() {
    super.initState();
    // Trigger the FetchClient event
    fetchData();
  }

  void fetchData() {
    _jobListBloc = JobListBloc(); // Initialize the ClientBloc
    _jobListBloc.add(FetchJobList(
        currentDate: widget.currentDate,
        userID: "${widget.userId}",
        jobListID: "${widget.jobStatus}"));
  }

  @override
  void dispose() {
    _jobListBloc.close(); // Close the bloc when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<JobListDetailsModel> jobListDetailsModel = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: ColorsPlatte.lightgreenshede),
        ),
        backgroundColor: ColorsPlatte.accentColor,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<JobListBloc, JobListState>(
        bloc: _jobListBloc,
        builder: (context, state) {
          if (state is JobListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobListLoaded) {
            return state.jobListDetailsModel.isNotEmpty
                ? ListView.builder(
                    itemCount: state.jobListDetailsModel.length,
                    itemBuilder: (context, index) {
                      final jobDetail = state.jobListDetailsModel[index];
                      return JobListCard(
                        job: jobDetail,
                        type: widget.type,
                      );
                    },
                  )
                : const Center(
                    child: Text(
                    "No Jobs Found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ));
          } else if (state is JobListError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('Please wait'));
          }
        },
      ),
    );
  }
}

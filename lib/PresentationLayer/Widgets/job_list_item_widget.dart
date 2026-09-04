import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';
import 'package:infoinstall/PresentationLayer/Components/constant.dart';
import 'package:infoinstall/PresentationLayer/Components/toast_message.dart';

import '../../DataLayer/Model/job_list_item_model.dart';
import '../Pages/job_detail_screen.dart';

class JobListCard extends StatefulWidget {
  final JobListDetailsModel job;
  final int type;

  const JobListCard({super.key, required this.job, required this.type});

  @override
  State<JobListCard> createState() => _JobListCardState();
}

class _JobListCardState extends State<JobListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: ColorsPlatte.getStatusColors(
                    widget.type), // Container background color
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  // const Icon(Icons.person, color: Colors.white), // Left icon
                  Expanded(
                    child: Text(
                      'Job ID: ${widget.job.jobId}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Right arrow icon
                ],
              ),
            ),
            ListTile(
              title: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client Name: ${widget.job.clientName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Purpose of Visit: ${widget.job.purposeOfVisit}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Job Location: ${widget.job.jobLocation}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    // const Text(
                    //   'Job Status',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // trailing: const Icon(
              //   Icons.arrow_forward_ios,
              //   color: Colors.black,
              // ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      if (widget.job.jobStatusId == 9) {
                        customToast(
                          message: "Job already completed",
                          color: Colors.green,
                        );
                      } else if (widget.job.jobStatusId == 8) {
                        customToast(
                          message: "Job already cancelled",
                          color: Colors.red,
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailsScreen(
                              jobDetails: widget.job,
                            ),
                          ),
                        );
                      }
                    },
                    elevation: 8,
                    color: widget.job.jobStatusId == 8
                        ? Colors.red[800]
                        : Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        getCapsStatus(widget.job.jobStatusId.toString()),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infoinstall/DataLayer/Model/device_list_detail_model.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/device_gps_detail_bloc.dart';
import 'package:infoinstall/PresentationLayer/Components/constant.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Components/toast_message.dart';
import 'package:infoinstall/PresentationLayer/Pages/device_details_screen.dart';
import '../../DataLayer/Model/job_list_item_model.dart';
import '../Pages/checkout_screen.dart';

class DeviceListItemDetail extends StatefulWidget {
  final DeviceListDetailsModel deviceListDetailsModel;
  final JobListDetailsModel jobDetails;
  final BuildContext context;

  const DeviceListItemDetail({
    Key? key,
    required this.context,
    required this.jobDetails,
    required this.deviceListDetailsModel,
  }) : super(key: key);

  @override
  State<DeviceListItemDetail> createState() => _DeviceListItemDetailState();
}

class _DeviceListItemDetailState extends State<DeviceListItemDetail>
    with PrintMixin {
  late DeviceGpsDetailBloc _deviceGpsDetailBloc;

  @override
  void initState() {
    super.initState();
    _deviceGpsDetailBloc = DeviceGpsDetailBloc();
  }

  @override
  void dispose() {
    _deviceGpsDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        p('Job status in build is : ${getJobStatusId(widget.deviceListDetailsModel.jobstatus ?? "NA")}'),
        if (getJobStatusId(widget.deviceListDetailsModel.jobstatus ?? "NA") ==
            7)
          {
            customToast(
              message: "Device is already completed",
              color: Colors.green.shade700,
            ),
          }
        else if (getJobStatusId(
                widget.deviceListDetailsModel.jobstatus ?? "NA") ==
            5)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckOutScreen(
                  widget.context,
                  widget.jobDetails,
                  widget.deviceListDetailsModel,
                  widget.jobDetails.deviceList!.length,
                ),
              ),
            ),
          }
        else
          {
            customToast(
              message: "Please check in to proceed further.",
              color: Colors.amber.shade700,
            ),
          }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                      'Vehicle No', widget.deviceListDetailsModel.vehicleNo),
                  _buildDetailRow(
                      'Sim No', widget.deviceListDetailsModel.mobileNo),
                  _buildDetailRow(
                      'Unit No', widget.deviceListDetailsModel.unitNo),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _buildStatusRow('Active',
                              (widget.deviceListDetailsModel.isActive)),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildStatusRow(
                              widget.jobDetails.purposeOfVisitId == 6
                                  ? 'Replaced'
                                  : (widget.jobDetails.purposeOfVisitId == 5
                                      ? 'Removed'
                                      : 'Installed'),
                              widget.jobDetails.purposeOfVisitId == 5
                                  ? (widget.deviceListDetailsModel
                                          .iSInstalled! ==
                                      0)
                                  : (widget
                                          .deviceListDetailsModel.iSInstalled! >
                                      1)),

                          // 2 for installation
                          // 1 for Assign
                          // 0 for Free
                        ],
                      ),
                      Center(
                        child: _buildCheckStatusButton(),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ],
              ),
              const Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('$label:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          Expanded(
              flex: 3,
              child: Text(value ?? 'N/A',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400))),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, bool? isActive) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        Icon((isActive ?? false) ? Icons.check_circle : Icons.cancel,
            color: (isActive ?? false) ? Colors.green[700] : Colors.red[700]),
      ],
    );
  }

  Widget _buildCheckStatusButton() {
    return MaterialButton(
      onPressed: () => {
        p('Status : ${getJobStatusId(widget.deviceListDetailsModel.jobstatus ?? "NA")}'),
        p('Status :${widget.deviceListDetailsModel.jobstatus}'),
        if (getJobStatusId(
                    widget.deviceListDetailsModel.jobstatus ?? "NA") ==
                5 ||
            getJobStatusId(widget.deviceListDetailsModel.jobstatus ?? "NA") ==
                6 ||
            getJobStatusId(widget.deviceListDetailsModel.jobstatus ?? "NA") ==
                7)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeviceGpsScreen(
                  unitNo: widget.deviceListDetailsModel.unitNo ?? "NA",
                  simNo: widget.deviceListDetailsModel.mobileNo ?? "NA",
                ),
              ),
            ),
          }
        else
          {
            customToast(
              message: "Please check in to proceed further.",
              color: Colors.amber.shade700,
            ),
          }
      },
      color: Colors.white,
      disabledColor: Colors.grey[600],
      // style: ElevatedButton.styleFrom(
      //   disabledBackgroundColor: Colors.blue[800], // Customise primary color
      //   backgroundColor: Colors.white, // Text color
      // ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('CHECK STATUS', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

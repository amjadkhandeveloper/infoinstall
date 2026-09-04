import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';

import 'device_list_item.dart';

class JobListItem extends StatefulWidget {
  final String title;
  final String status;
  final String clientName;
  final DateTime dateTime;
  final String location;
  final int type;
  final List<String> deviceList;

  const JobListItem({
    Key? key,
    required this.title,
    required this.status,
    required this.clientName,
    required this.dateTime,
    required this.location,
    required this.type,
    required this.deviceList,
  }) : super(key: key);

  @override
  State<JobListItem> createState() => _JobListItemState();
}

class _JobListItemState extends State<JobListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: ColorsPlatte.getStatusColors(widget.type),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Job ID: ${widget.title}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
                Icons.perm_device_information, 'Status', widget.status),
            _buildInfoRow(
                Icons.supervised_user_circle, 'Client', widget.clientName),
            _buildInfoRow(Icons.calendar_month, 'Date', _formattedDate),
            _buildInfoRow(Icons.location_on, 'Location', widget.location),
            _buildInfoRow(Icons.devices, 'Devices to Install',
                widget.deviceList.length.toString()),
            const SizedBox(height: 8),
            _buildDevicesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text(
            '$label: $value',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevicesList() {
    bool isList = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => {
            isList = !isList,
            setState(() {}),
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Devices List:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                color: Colors.red[900],
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        isList
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.deviceList.length,
                itemBuilder: (context, index) {
                  return DeviceListItem(deviceId: widget.deviceList[index]);
                },
              )
            : Container(),
      ],
    );
  }

  String get _formattedDate {
    return '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}';
  }
}

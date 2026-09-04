import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class DeviceListItem extends StatelessWidget {
  final String deviceId;

  const DeviceListItem({Key? key, required this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              deviceId,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red[900],
                onPressed: () {
                  // Handle delete button press
                  // Add your logic here

                  Logger('Delete $deviceId');
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.done),
                color: Colors.green,
                onPressed: () {
                  // Handle done button press
                  // Add your logic here
                  Logger('Done $deviceId');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';

import '../../DataLayer/Model/client_details_model.dart';

class ClientListItem extends StatelessWidget {
  final ClientDetailsModel clientDetailsModel;

  const ClientListItem({
    super.key,
    required this.clientDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsPlatte.lightgreenshede,
      shadowColor: Colors.black,
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: IntrinsicHeight(
        // Ensure the children of Row match in height
        child: Row(
          children: [
            Container(
              width: 8,
              decoration: BoxDecoration(
                color: ColorsPlatte.getStatusColors(11),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              // Wrapping the Padding with Expanded
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${clientDetailsModel.clientName}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Contact: ${clientDetailsModel.mobileNO}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Number of Jobs: ${clientDetailsModel.jobCount}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Address: ${clientDetailsModel.address}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

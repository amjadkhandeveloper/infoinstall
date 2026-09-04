import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';

import '../Components/text_style.dart';
import 'job_details_card_widget.dart';

class CustomerDetailsCardWidget extends StatefulWidget {
  const CustomerDetailsCardWidget({
    super.key,
    required this.size,
    required this.clientName,
    required this.location,
    required this.purposeOfVisit,
  });

  final Size size;
  final String clientName;
  final String location;
  final String purposeOfVisit;

  @override
  State<CustomerDetailsCardWidget> createState() =>
      _CustomerDetailsCardWidgetState();
}

class _CustomerDetailsCardWidgetState extends State<CustomerDetailsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: widget.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: ColorsPlatte.primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: widget.size.width,
            decoration: const BoxDecoration(
              color: ColorsPlatte.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Text(
              "Customer details",
              style: TextStyles.title2(
                context: context,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JobDetailsCard2EntityWidget(
                  title: "Client Name:",
                  value: widget.clientName,
                ),
                JobDetailsCard2EntityWidget(
                  title: "Location",
                  value: widget.location,
                ),
                Text(
                  "Purpose",
                  style: TextStyles.title2(
                    context: context,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.purposeOfVisit,
                  style: TextStyles.subTitle1(
                    context: context,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';

import '../../DataLayer/Model/job_response_model.dart';
import '../Components/text_style.dart';

class JobDetailCard2 extends StatelessWidget {
  final JobResponseModelDataJobdet? job;
  const JobDetailCard2({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.primaryColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: ColorsPlatte.customBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JobDetailsCard2EntityWidget(
            title: "Contack Person Name:",
            value: job!.ContactName.toString(),
          ),
          const SizedBox(
            height: 4,
          ),
          JobDetailsCard2EntityWidget(
            title: "Company Name:",
            value: job!.CompanyName.toString(),
          ),
          const SizedBox(
            height: 4,
          ),
          JobDetailsCard2EntityWidget(
            title: "Purpose:",
            value: job!.PurposeOfVisit.toString(),
          ),
          const SizedBox(
            height: 4,
          ),
          const JobDetailsCard2EntityWidget(
            title: "Approx dist. in KM (From current location)",
            value: "45",
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Address:",
            style: TextStyles.title2(
              context: context,
            ),
          ),
          Text(
            job!.JobLocation.toString(),
            style: TextStyles.subTitle1(
              context: context,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class JobDetailsCard2EntityWidget extends StatelessWidget {
  final String title;
  final String value;
  const JobDetailsCard2EntityWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.title2(
            context: context,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: TextStyles.subTitle1(
            context: context,
            color: Colors.grey,
          ),
        ),
        Divider(
          color: ColorsPlatte.primaryColor.withOpacity(0.5),
        ),
      ],
    );
  }
}

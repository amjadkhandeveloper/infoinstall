import 'package:flutter/material.dart';
import '../Components/text_style.dart';

class PoweredBy extends StatefulWidget {
  const PoweredBy({super.key});

  @override
  State<PoweredBy> createState() => _PoweredByState();
}

class _PoweredByState extends State<PoweredBy> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Need Help? Call: +91 80 4282 9444,",
          style: TextStyles.subTitle2(context: context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Powered By"),
            const Text(
              "Info",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              "Track",
              style: TextStyle(
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

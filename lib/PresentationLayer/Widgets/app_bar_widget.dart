import 'package:flutter/material.dart';

import '../Components/color_plattes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String heading;

  const CustomAppBar({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        heading,
        style: const TextStyle(color: ColorsPlatte.lightgreenshede),
      ),
      backgroundColor:
          ColorsPlatte.accentColor, // Assuming this is your accent color
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

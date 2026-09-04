import 'package:flutter/material.dart';

class ColorsPlatte {
  static const Color backgroudColor = Color.fromARGB(255, 241, 251, 252);
  // static const Color primaryColor = Color(0xFF233743);
  static const Color primaryColor = Color(0xFF78C9D2);
  static const Color accentColor = Color(0xFF009CAC);
  static const Color darkaccentColor = Color.fromARGB(255, 2, 67, 74);
  static const Color customRedColor = Color(0xffef2119);
  static const Color customGreenColor = Color(0xff22b100);
  static const Color customGreyColor = Color(0xfff7f8f9);

  static const Color lightgreenshede = Color(0xFFF0FAF6);
  static const Color lightgreenshede1 = Color(0xFFB2D9CC);
  static const Color greenshede0 = Color(0xFF66A690);
  static const Color greenshede1 = Color(0xFF93C9B5);
  static const Color primarygreen = Color(0xFF1E3A34);
  static const Color grayshade = Color(0xFF93B3AA);
  static const Color colorAcent = Color(0xFF78C2A7);
  static const Color cyanColor = Color(0xFF6D7E6E);
  static const Color blackColor = Color(0xFF000000);

  static const Color pendingColor = Color.fromARGB(255, 255, 94, 0);
  static const Color completedColor = Color.fromARGB(255, 5, 81, 5);
  static const Color inProgressColor = Color.fromARGB(255, 248, 196, 26);
  static const Color cancelledColor = Color.fromARGB(255, 184, 10, 45);
  static const Color notStartedColor = Color.fromARGB(255, 105, 105, 105);
  static const Color acceptedColor = Color.fromARGB(255, 106, 244, 106);
  static const Color enrouteColor = Color.fromARGB(255, 145, 7, 129);
  static const Color rescheduleColor = Color.fromARGB(255, 255, 0, 0);
  static const Color checInColor = Color.fromARGB(255, 255, 192, 4);
  static const Color checOutColor = Color.fromARGB(255, 14, 153, 54);
  static const Color installationCompleteColor =
      Color.fromARGB(255, 48, 10, 184);

  static const Color clientColor = Color.fromARGB(255, 9, 83, 141);
  static const Color installerColor = Color.fromARGB(255, 21, 2, 103);

  static Color getJobColor(int index) {
    List<Color> colors = [
      notStartedColor,
      acceptedColor,
      enrouteColor,
      rescheduleColor,
      checInColor,
      checOutColor,
      completedColor,
      cancelledColor,
      installationCompleteColor,
    ];
    return colors[index % colors.length];
  }

  static Color getStatusColors(int type) {
    if (type == 1) {
      return pendingColor;
    } else if (type == 2) {
      return inProgressColor;
    } else if (type == 3) {
      return completedColor;
    } else if (type == 4) {
      return cancelledColor;
    } else if (type == 11) {
      return clientColor;
    } else if (type == 12) {
      return installerColor;
    } else {
      return accentColor;
    }
  }

  static List<BoxShadow>? customBoxShadow = const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 4),
      spreadRadius: 0,
    )
  ];

  static Color getColor(int index) {
    List<Color> colors = [
      ColorsPlatte.pendingColor,
      ColorsPlatte.inProgressColor,
      ColorsPlatte.completedColor,
      ColorsPlatte.cancelledColor,
    ];
    return colors[index % colors.length];
  }
}

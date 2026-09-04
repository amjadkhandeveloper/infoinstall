import 'package:flutter/material.dart';

import '../../DataLayer/Model/dashbaord_item.dart';

class DashboardCard extends StatelessWidget {
  final DashboardData dashboardData;
  final Color cardColor;
  final Color iconColor;
  const DashboardCard(
      {Key? key,
      required this.dashboardData,
      required this.cardColor,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 5,
    //   margin: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
    //   color: iconColor,
    //   child: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: ListTile(
    // leading: SizedBox(
    //   height: 40,
    //   width: 40,
    //   child: ColorFiltered(
    //     colorFilter: ColorFilter.mode(
    //       cardColor,
    //       BlendMode.srcIn,
    //     ), // Adjust color and blend mode as needed
    //     child: dashboardData.icon,
    //   ),
    // ),
    //       title: Text(
    //         dashboardData.title,
    //         style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 24,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       trailing: Text(
    //         '${dashboardData.count}',
    //         style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 24,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
      color: iconColor, // The background color of the Card
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Column(
            mainAxisSize: MainAxisSize.min, //
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              cardColor, // Color of the filter applied to the icon
                              BlendMode.srcIn,
                            ),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                cardColor,
                                BlendMode.srcIn,
                              ), // Adjust color and blend mode as needed
                              child: dashboardData.icon,
                            ), // Assuming the icon is an image asset
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dashboardData.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: Text(
                      '${dashboardData.count}',
                      style: TextStyle(
                        color: cardColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),

        // child: ListTile(
        //   leading:
        //   title:
        //   // Remove the trailing property if not required
        // ),
      ),
    );

    // return Card(
    //   elevation: 5,
    //   margin: const EdgeInsets.all(16),
    //   color: iconColor,
    //   child: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Row(
    //               children: [
    //                 CircleAvatar(
    //                   radius: 28,
    //                   backgroundColor: ColorsPlatte.lightgreenshede,
    //                   child: Icon(
    //                     dashboardData.icon,
    //                     size: 40,
    //                     color: cardColor,
    //                   ),
    //                 ),
    //                 const SizedBox(width: 16),
    //                 Text(
    //                   '${dashboardData.count}',
    //                   style: const TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 24,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             // Add any other widgets you want in the row here
    //           ],
    //         ),
    //         const SizedBox(height: 16),
    //         Text(
    //           dashboardData.title,
    //           style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 24,
    //             color: Colors.black,
    //           ),
    //         ),
    //         const SizedBox(height: 8),
    //         Text(
    //           dashboardData.description,
    //           style: const TextStyle(
    //             fontSize: 16,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

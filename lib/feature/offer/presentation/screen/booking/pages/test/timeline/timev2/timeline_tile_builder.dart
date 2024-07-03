// import 'package:flutter/material.dart';
// import 'package:timeline_tile/timeline_tile.dart';
// import 'step_status.dart';

// class TimelineTileBuilder {
//   static Widget buildTimelineTile({
//     bool isFirst = false,
//     bool isLast = false,
//     required StepStatus? status,
//     required String label,
//     required Widget indicator,
//   }) {
//     return Expanded(
//       child: TimelineTile(
//         alignment: TimelineAlign.center,
//         axis: TimelineAxis.horizontal,
//         isFirst: isFirst,
//         isLast: isLast,
//         indicatorStyle: IndicatorStyle(
//           width: 40,
//           height: 40,
//           indicator: indicator,
//         ),
//         beforeLineStyle: LineStyle(
//           color: Colors.teal,
//           thickness: 2,
//         ),
//         afterLineStyle: LineStyle(
//           color: Colors.teal,
//           thickness: 2,
//         ),
//         endChild: Container(
//           constraints: BoxConstraints(
//             minWidth: 100,
//           ),
//           child: Center(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// List<String> matchRecWithTime(
//     List<Map<String, dynamic>> prices, List<Map<String, dynamic>> times) {
//   List<String> matchingTimesList = [];

//   for (var price in prices) {
//     List<String> recTimes = _extractTimesFromRec(price['rec']);
//     List<String> matchingTimes = times
//         .where((time) => recTimes.contains(time['time']))
//         .map((time) => time['time'] as String)
//         .toList();

//     matchingTimesList.add('Price: ${price['name']}');
//     matchingTimesList.add('Matching Times: $matchingTimes');
//     matchingTimesList.add('---');
//   }
//   return matchingTimesList;
// }

// List<String> _extractTimesFromRec(String rec) {
//   List<String> times = [];
//   List<String> parts = rec.split(' - ');
//   if (parts.length == 2) {
//     double start = _parseTime(parts[0]);
//     double end = _parseTime(parts[1]);

//     for (double t = start; t <= end; t += 1.0) {
//       times.add(_formatTime(t));
//     }
//   } else {
//     times.add(parts[0]);
//   }
//   return times;
// }

// double _parseTime(String time) {
//   return double.parse(time.split(' ')[0]);
// }

// String _formatTime(double time) {
//   return time % 1 == 0
//       ? '${time.toInt()} ຊ.ມ'
//       : '${time.toStringAsFixed(1)} ຊ.ມ';
// }

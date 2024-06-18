// import 'dart:convert';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PostJobCubit extends Cubit<List<Map<String, dynamic>>> {
//   PostJobCubit() : super([]) {
//     _loadPostJobIds();
//   }

//   void addPostJobId(String postJobId) async {
//     final timestamp = DateTime.now().toIso8601String();
//     final updatedList = List<Map<String, dynamic>>.from(state)
//       ..add({'postJobId': postJobId, 'timestamp': timestamp});
//     emit(updatedList);
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('postJobIds', jsonEncode(updatedList));
//   }

//   void _loadPostJobIds() async {
//     final prefs = await SharedPreferences.getInstance();
//     final postJobIdsString = prefs.getString('postJobIds');
//     if (postJobIdsString != null) {
//       final postJobIds = jsonDecode(postJobIdsString);
//       emit(List<Map<String, dynamic>>.from(postJobIds));
//     }
//   }

//   void clearPostJobIdsOlderThan(Duration duration) async {
//     final now = DateTime.now();
//     final updatedList = state.where((entry) {
//       final entryTime = DateTime.parse(entry['timestamp']);
//       return now.difference(entryTime) < duration;
//     }).toList();
//     emit(updatedList);
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('postJobIds', jsonEncode(updatedList));
//   }
// }

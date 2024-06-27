import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'choose_state.dart';

class ChooseCubit extends Cubit<ChooseState> {
  final String postJobId;
  final http.Client httpClient;

  ChooseCubit(this.postJobId, this.httpClient) : super(ChooseState.initial()) {
    _fetchCleaners();
  }

  Future<void> _fetchCleaners() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('accessToken');
    final url =
        'http://18.142.53.143:9393/api/v1/job/post-jop-hunter-info/$postJobId';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await httpClient.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final cleanerData = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        emit(state.copyWith(cleanerData: cleanerData, isLoading: false));
      } else {
        print('Failed to fetch cleaner data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching cleaner data: $e');
    }
  }

  Future<void> chooseCleaner(String hunterUsername) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('accessToken');
    final url = 'http://18.142.53.143:9393/api/v1/job/choose-hunter/';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      "bill_code": postJobId,
      "status": "MATCH_HUNTER",
      "hunter_username": hunterUsername,
    });

    try {
      final response =
          await httpClient.put(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Cleaner chosen successfully');
      } else {
        print('Failed to choose cleaner: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error choosing cleaner: $e');
    }
  }
}

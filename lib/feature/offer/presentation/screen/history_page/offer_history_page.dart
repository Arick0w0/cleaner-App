// presentation/pages/history_user_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/historyuser/history_user_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/historyuser/history_user_state.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/widget/booking_card.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

class HistoryUserPage extends StatefulWidget {
  const HistoryUserPage({super.key});

  @override
  _HistoryUserPageState createState() => _HistoryUserPageState();
}

class _HistoryUserPageState extends State<HistoryUserPage> {
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getToken();
    final user = await localStorageService.getUserFromToken();

    if (token != null && user != null) {
      context
          .read<HistoryUserCubit>()
          .loadHistoryUserBookings(token, user.username);
    } else {
      context
          .read<HistoryUserCubit>()
          .emit(HistoryUserError(message: 'Failed to retrieve token or user.'));
    }
  }

  Future<void> _refreshBookings() async {
    await _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryUserCubit, HistoryUserState>(
        builder: (context, state) {
          if (state is HistoryUserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryUserLoaded) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: _refreshBookings,
              child: ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookingCard(booking: booking),
                  );
                },
              ),
            );
          } else if (state is HistoryUserNoData) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: _refreshBookings,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo/gost.gif'),
                      Text(
                        'ບໍ່ມີປະຫວັດ',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HistoryUserError) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: _refreshBookings,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                        const Gap(16),
                        Text(state.message,
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const Gap(16),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: _refreshBookings,
                            child: Text('Retry'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: _refreshBookings,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("No data"),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

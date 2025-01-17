import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/history/history_cubit.dart';
import '../../widget/activity_card.dart';

class HistoryHunterPage extends StatefulWidget {
  const HistoryHunterPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryHunterPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<HistoryCubit>().fetchHistory(),
              child: ListView.builder(
                itemCount: state.history.length,
                itemBuilder: (context, index) {
                  final booking = state.history[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IgnorePointer(
                      ignoring: booking.status == 'NOT_MATCHED',
                      child: GestureDetector(
                        onTap: () {
                          print('Booking ID: ${booking.id}');
                          context.go('/history-hunter', extra: booking.id);
                        },
                        child: ActivityCard(
                          booking: booking,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is HistoryNoData) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<HistoryCubit>().fetchHistory(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/logo/gost.gif'),
                          Text(
                            'ບໍ່ມີປະຫວັດ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HistoryError) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<HistoryCubit>().fetchHistory(),
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
                            onPressed: () =>
                                context.read<HistoryCubit>().fetchHistory(),
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
              onRefresh: () => context.read<HistoryCubit>().fetchHistory(),
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

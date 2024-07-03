import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/widgets/confirmation_dialog.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/activity/booking_cubit.dart';
import '../../widget/activity_card.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({super.key});

  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingLoaded) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<BookingCubit>().fetchBookings(),
              child: ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IgnorePointer(
                      ignoring: booking.status == 'NOT_MATCHED',
                      child: GestureDetector(
                        onTap: () {
                          print('Booking ID: ${booking.id}');
                          context.go('/detail-hunter', extra: booking.id);
                        },
                        child: ActivityCard(
                          booking: booking,
                          onPressed: () => showConfirmationDialog(
                            context: context,
                            title: 'ທ່ານຕ້ອງການຕອບຮັບວຽກນີ້ແທ້ບໍ?',
                            content:
                                'ຕອບຮັບແລ້ວກະລຸນາລໍຖ້າການຍືນຍັນຈາກຜູ້ໃຊ້ບໍລິການ?',
                            onAccept: () {
                              context
                                  .read<BookingCubit>()
                                  .onAcceptBooking(booking.orderNumber);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is BookingNoData) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<BookingCubit>().fetchBookings(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Image.asset('assets/logo/gost.gif'),
                ),
              ),
            );
          } else if (state is BookingError) {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<BookingCubit>().fetchBookings(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(state.message),
                  ),
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              color: MColors.accent,
              onRefresh: () => context.read<BookingCubit>().fetchBookings(),
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

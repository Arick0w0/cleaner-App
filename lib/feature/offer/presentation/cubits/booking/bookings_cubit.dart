// presentation/cubits/booking/my_booking_cubit.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/domain/usecases/fetch_my_bookings.dart';
import 'dart:io';

class MyBookingCubit extends Cubit<MyBookingState> {
  final FetchMyBookings fetchMyBookings;
  final Connectivity connectivity;

  MyBookingCubit({required this.fetchMyBookings, required this.connectivity})
      : super(MyBookingInitial());

  Future<void> fetchBookings(String token, String username) async {
    emit(MyBookingLoading());
    while (true) {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(const MyBookingError(message: 'No internet connection.'));
        await Future.delayed(
            const Duration(seconds: 5)); // Retry after 5 seconds
      } else {
        try {
          final bookings = await fetchMyBookings.execute(token, username);
          if (bookings.isEmpty) {
            emit(MyBookingNoData());
          } else {
            emit(MyBookingLoaded(bookings));
          }
          break;
        } catch (e) {
          if (e is SocketException) {
            emit(const MyBookingError(message: 'No internet connection.'));
          } else if (e.toString().contains('No data found')) {
            emit(MyBookingNoData());
          } else {
            emit(MyBookingError(message: e.toString()));
          }
          break;
        }
      }
    }
  }
}

abstract class MyBookingState extends Equatable {
  const MyBookingState();

  @override
  List<Object> get props => [];
}

class MyBookingInitial extends MyBookingState {}

class MyBookingLoading extends MyBookingState {}

class MyBookingLoaded extends MyBookingState {
  final List<Booking> bookings;

  const MyBookingLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class MyBookingNoData extends MyBookingState {}

class MyBookingError extends MyBookingState {
  final String message;

  const MyBookingError({required this.message});

  @override
  List<Object> get props => [message];
}

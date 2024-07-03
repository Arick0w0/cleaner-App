// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mae_ban/feature/hunter/domain/usecases/accept_booking.dart';
// import 'package:mae_ban/feature/hunter/domain/usecases/get_bookings.dart';
// import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

// abstract class BookingState {}

// class BookingInitial extends BookingState {}

// class BookingLoading extends BookingState {}

// class BookingLoaded extends BookingState {
//   final List<Booking> bookings;

//   BookingLoaded({required this.bookings});
// }

// class BookingError extends BookingState {
//   final String message;

//   BookingError({required this.message});
// }

// class BookingCubit extends Cubit<BookingState> {
//   final GetBookings getBookings;
//   final AcceptBooking acceptBooking;

//   BookingCubit({required this.getBookings, required this.acceptBooking})
//       : super(BookingInitial());

//   Future<void> fetchBookings() async {
//     try {
//       emit(BookingLoading());
//       final bookings = await getBookings();
//       emit(BookingLoaded(bookings: bookings));
//     } catch (e) {
//       emit(BookingError(message: e.toString()));
//     }
//   }

//   Future<void> onAcceptBooking(String billCode) async {
//     try {
//       await acceptBooking(billCode);
//       fetchBookings(); // Refresh bookings after accepting
//     } catch (e) {
//       emit(BookingError(message: e.toString()));
//     }
//   }
// }

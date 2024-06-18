import 'package:bloc/bloc.dart';
import 'package:mae_ban/core/utils/network_info.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_booking.dart';
import 'package:dartz/dartz.dart';
import 'package:mae_ban/core/error/failures.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBooking getBooking;
  final NetworkInfo networkInfo;

  BookingBloc({required this.getBooking, required this.networkInfo})
      : super(BookingInitial()) {
    on<FetchBookingData>(_onFetchBookingData);
  }

  Future<void> _onFetchBookingData(
      FetchBookingData event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    if (await networkInfo.isConnected) {
      final failureOrBooking = await getBooking(NoParams());
      emit(_eitherLoadedOrErrorState(failureOrBooking));
    } else {
      emit(BookingError('ไม่มีการเชื่อมต่ออินเทอร์เน็ต'));
    }
  }

  BookingState _eitherLoadedOrErrorState(
      Either<Failure, Booking> failureOrBooking) {
    return failureOrBooking.fold(
      (failure) => BookingError(_mapFailureToMessage(failure)),
      (booking) => BookingLoaded(booking),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}

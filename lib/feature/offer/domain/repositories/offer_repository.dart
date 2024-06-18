import 'package:dartz/dartz.dart';
import 'package:mae_ban/core/error/failures.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

abstract class OfferRepository {
  Future<Either<Failure, Booking>> fetchBooking();
}

import 'package:dartz/dartz.dart';
import 'package:mae_ban/core/error/failures.dart';
import 'package:mae_ban/core/usecases/usecase.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/domain/repositories/offer_repository.dart';

class GetBooking implements UseCase<Booking, NoParams> {
  final OfferRepository repository;

  GetBooking(this.repository);

  @override
  Future<Either<Failure, Booking>> call(NoParams params) async {
    return await repository.fetchBooking();
  }
}

class NoParams {}


// import 'package:dartz/dartz.dart';
// import 'package:mae_ban/core/error/failures.dart';
// import 'package:mae_ban/core/usecases/usecase.dart';
// import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
// import 'package:mae_ban/feature/offer/domain/repositories/offer_repository.dart';

// class GetBooking implements UseCase<Booking, NoParams> {
//   final OfferRepository repository;

//   GetBooking(this.repository);

//   @override
//   Future<Either<Failure, Booking>> call(NoParams params) async {
//     return await repository.fetchBooking().then((booking) => Right(booking));
//   }
// }

// class NoParams {}

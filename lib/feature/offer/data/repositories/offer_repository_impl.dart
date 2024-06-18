// import 'package:dartz/dartz.dart';
// import 'package:mae_ban/core/error/exceptions.dart';
// import 'package:mae_ban/core/error/failures.dart';
// import 'package:mae_ban/feature/offer/data/datasources/offer_remote_data_source.dart';
// import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
// import 'package:mae_ban/feature/offer/domain/repositories/offer_repository.dart';

// class OfferRepositoryImpl implements OfferRepository {
//   final OfferRemoteDataSource remoteDataSource;

//   OfferRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<Either<Failure, Booking>> fetchBooking() async {
//     try {
//       final booking = await remoteDataSource.fetchBooking();
//       return Right(booking);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
// }

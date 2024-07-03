import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/core/utils/network_info.dart';
import 'package:mae_ban/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mae_ban/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:mae_ban/feature/auth/data/service/api_service.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';
import 'package:mae_ban/feature/auth/domain/usecases/login.dart';
import 'package:mae_ban/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_hunter.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_offer.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:mae_ban/feature/hunter/domain/repositories/start_job_repository.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/accept_booking.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_history.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/activity/booking_cubit.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/start_job/start_job_cubit.dart';
import 'package:mae_ban/feature/offer/data/datasources/offer_remote_data_source.dart';
import 'package:mae_ban/feature/offer/data/datasources/price_remote_data_source.dart';
import 'package:mae_ban/feature/offer/data/repositories/price_repository_impl.dart';
import 'package:mae_ban/feature/offer/domain/repositories/offer_repository.dart';
import 'package:mae_ban/feature/offer/domain/repositories/price_repository.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_booking.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_prices.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/price/price_bloc.dart';

import 'package:mae_ban/feature/offer/presentation/blocs/service_type/service_type_bloc.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_bloc.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/selection/selection_cubit.dart';
import 'package:mae_ban/feature/shared/data/services/api_service.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'feature/auth/data/local_storage/local_storage_service.dart';
import 'feature/hunter/data/datasource/start_job_remote_data_source.dart';
import 'feature/hunter/data/repositories/booking_repository.dart';
import 'feature/hunter/data/repositories/job_detail_repository.dart';
import 'feature/hunter/data/datasource/booking_remote_data_source.dart';
import 'feature/hunter/data/datasource/history_remote_data_source.dart';
import 'feature/hunter/data/datasource/job_detail_remote_data_source.dart';
import 'feature/hunter/data/repositories/start_job_repository_impl.dart';
import 'feature/hunter/domain/usecases/get_bookings.dart';
import 'feature/hunter/domain/usecases/get_job_detail.dart';
import 'feature/hunter/domain/usecases/get_start_job.dart';
import 'feature/hunter/domain/usecases/submit_status_process.dart';
import 'feature/hunter/presentation/cubit/bookinghunter_cubit.dart';
import 'feature/hunter/presentation/cubit/history/history_cubit.dart';
import 'feature/hunter/presentation/cubit/job_detail/job_detail_cubit.dart';
import 'feature/offer/data/datasources/service_remote_data_source.dart';
import 'feature/offer/data/datasources/time_remote_datasource.dart';
import 'feature/offer/data/repositories/service_type_repository_impl.dart';
import 'feature/offer/data/repositories/time_repository_impl.dart';
import 'feature/offer/domain/repositories/service_type_repository.dart';
import 'feature/offer/domain/repositories/time_repository.dart';
import 'feature/offer/domain/usecases/get_service_types.dart';
import 'feature/offer/domain/usecases/get_times.dart';
import 'feature/offer/presentation/cubits/time/time_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // Local Storage Service
  sl.registerLazySingleton(() => LocalStorageService());
  // Api Service
  sl.registerLazySingleton(
      () => ApiService(client: sl<http.Client>(), baseUrl: Config.apiBaseUrl));
  sl.registerLazySingleton(() => ApiServiceGet());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpJobOffer(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignUpJobHunter(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl<AuthRepository>()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
        signupJobOffer: sl<SignUpJobOffer>(),
        signupJobHunter: sl<SignUpJobHunter>(),
        login: sl<Login>(),
        resetPasswordUseCase: sl<ResetPasswordUseCase>(),
      ));
  sl.registerFactory(() => UserCubit());

  // External
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<Connectivity>()));

  // Data sources for offers
  // sl.registerLazySingleton<OfferRemoteDataSource>(
  //     () => OfferRemoteDataSourceImpl());

  // // Repository for offers
  // sl.registerLazySingleton<OfferRepository>(
  //     () => OfferRepositoryImpl(sl<OfferRemoteDataSource>()));

  // Use cases for offers
  sl.registerLazySingleton(() => GetBooking(sl<OfferRepository>()));

  // Bloc for offers
  sl.registerFactory(() => BookingBloc(
        getBooking: sl<GetBooking>(),
        networkInfo: sl<NetworkInfo>(),
      ));

  // Shared data Blocs
  sl.registerFactory(() => DataBloc(apiService: sl()));
  sl.registerFactory(() => SelectionBloc());

  // ##################### Offer  ############################################
  // ServiceType Data sources
  sl.registerLazySingleton<ServiceTypeRemoteDataSource>(
    () => ServiceTypeRemoteDataSourceImpl(client: sl()),
  );

  // ServiceType Repositories
  sl.registerLazySingleton<ServiceTypeRepository>(
    () => ServiceTypeRepositoryImpl(remoteDataSource: sl()),
  );

  // ServiceType Use cases
  sl.registerLazySingleton(() => GetServiceTypes(repository: sl()));

  // ServiceType Blocs
  sl.registerFactory(
    () => ServiceTypeBloc(getServiceTypes: sl()),
  );

  // ##################### Offer  ############################################
  // Data sources
  sl.registerLazySingleton<PriceRemoteDataSource>(
      () => PriceRemoteDataSourceImpl(client: sl()));

  // Repositories
  sl.registerLazySingleton<PriceRepository>(
      () => PriceRepositoryImpl(remoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPrices(sl()));

// Cubit
  sl.registerFactory(() => SelectionCubit());

  // Blocs
  sl.registerFactory(() => PriceBloc(sl()));

  // ##################### Get time   ############################################

  // Cubit
  // sl.registerFactory(() => PostJobCubit());

  // Time feature
  sl.registerLazySingleton<TimeRemoteDataSource>(
      () => TimeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TimeRepository>(
      () => TimeRepositoryImpl(remoteDataSource: sl<TimeRemoteDataSource>()));
  sl.registerLazySingleton(() => GetTimes(sl<TimeRepository>()));
  sl.registerFactory(() => TimeCubit(getTimes: sl()));

  // ##################### Hunter   ############################################

  // Data sources
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(
      client: sl(),
      localStorageService: sl<LocalStorageService>(),
      // connectivity: sl<Connectivity>()
    ),
  );
  sl.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(
        client: sl(), localStorageService: sl<LocalStorageService>()),
  );

  // Repository
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(
        bookingRemoteDataSource: sl(),
        historyRemoteDataSource: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetBookings(repository: sl()));
  sl.registerLazySingleton(() => AcceptBooking(repository: sl()));
  sl.registerLazySingleton(() => GetHistory(repository: sl()));

  // Cubit
  sl.registerFactory(
      () => BookingCubit(getBookings: sl(), acceptBooking: sl()));
  sl.registerFactory(() => HistoryCubit(getHistory: sl()));
  // ##################### Hunter JOB DeTail   ############################################

  // Data sources
  sl.registerLazySingleton<JobDetailRemoteDataSource>(
    () => JobDetailRemoteDataSourceImpl(client: sl()),
  );

  // Repository
  sl.registerLazySingleton<JobDetailRepository>(
    () => JobDetailRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetJobDetail(repository: sl()));

  // Cubit
  sl.registerFactory(() => JobDetailCubit(getJobDetail: sl()));

  ///start job ////
  sl.registerLazySingleton<StartJobDetailRemoteDataSource>(
      () => StartJobDetailRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<StartJobRepository>(() =>
      StartJobDetailRepositoryImpl(
          remoteDataSource: sl<StartJobDetailRemoteDataSource>()));
  sl.registerLazySingleton<FetchStartJobDetailUseCase>(
      () => FetchStartJobDetailUseCase(sl<StartJobRepository>()));
  sl.registerLazySingleton<SubmitStatusProcessUseCase>(
      () => SubmitStatusProcessUseCase(sl<StartJobRepository>()));
  sl.registerFactory<StartJobCubit>(() => StartJobCubit(
      sl<FetchStartJobDetailUseCase>(), sl<SubmitStatusProcessUseCase>()));
}

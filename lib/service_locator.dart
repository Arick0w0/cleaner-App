import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mae_ban/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:mae_ban/feature/auth/data/service/api_service.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';
import 'package:mae_ban/feature/auth/domain/usecases/login.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_hunter.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_offer.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());

  // Api Service
  sl.registerLazySingleton(() => ApiService(client: sl()));
  sl.registerLazySingleton(() => ApiServiceGet());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpJobOffer(sl()));
  sl.registerLazySingleton(() => SignUpJobHunter(sl()));
  sl.registerLazySingleton(() => Login(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
        signupJobOffer: sl(),
        signupJobHunter: sl(),
        login: sl(),
      ));

  // Shared Blocs
  sl.registerFactory(() => DataBloc(apiService: sl()));
  sl.registerFactory(() => SelectionBloc());
}

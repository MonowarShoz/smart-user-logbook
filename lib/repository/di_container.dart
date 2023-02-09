import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:technoart_monitoring/Provider/location_provider.dart';
import 'package:technoart_monitoring/Provider/menu_provider.dart';

import '../Provider/data_provider.dart';
import '../api_services/Dio/dio_client.dart';
import '../api_services/Dio/logging_interceptor.dart';
import '../util/app_const.dart';
import 'data_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(
    () => DioClient(
      AppConsts.baseUrl,
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton(() => DataRepo(dioClient: sl()));
  sl.registerFactory(
    () => DataProvider(sl()),
  );

  sl.registerLazySingleton(() => Dio());
  sl.registerFactory(() => MenuProvider());
  sl.registerFactory(() => LocationProvider());
  sl.registerLazySingleton(() => LoggingInterceptor());
}

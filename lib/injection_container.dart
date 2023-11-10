import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dummy_clean_project/core/client/app_client.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_local_data_source.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/data/repositories/product_repository_impl.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_detail.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:dummy_clean_project/features/products/service/product_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    //! Product Service
    ..registerSingleton(
      AppClient().getService<ProductService>(),
    )
    ..registerLazySingleton(() => sharedPreferences)

    //! Data sources
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        productListService: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    )

    //! Repository
    ..registerLazySingleton<ProductRepository>(
      () =>
          ProductRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
    )

    //! Usecases
    ..registerLazySingleton(() => GetProductList(sl()))
    ..registerLazySingleton(() => GetProductDetail(sl()))

    //! Bloc
    ..registerFactory(
      () => ProductBloc(
        sl(),
        sl(),
      ),
    )

    //! connectivity_plus instance created
    ..registerLazySingleton(Connectivity.new)
    //! connectivity_plus injected
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

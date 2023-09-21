import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dummy_clean_project/core/client/app_client.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/data/repositories/product_repository_impl.dart';
import 'package:dummy_clean_project/features/products/data/service/product_service.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_detail.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product List
  sl
    ..registerSingleton(
      AppClient().getService<ProductListService>(),
    )
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerFactory(
      () => ProductBloc(sl(), sl()),
    )
    ..registerLazySingleton(() => GetProductList(sl()))
    ..registerLazySingleton(() => GetProductDetail(sl()))
    //! Repository
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()),
    )

    //! Data sources
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        productListService: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton(Connectivity.new);
}

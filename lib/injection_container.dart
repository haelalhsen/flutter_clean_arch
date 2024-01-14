import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

import 'core/network/network_info.dart';
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/login.dart';
import 'features/auth/presentation/manager/auth_cubit.dart';
import 'features/pokemons/data/data_sources/pokemon_remote_data_source.dart';
import 'features/pokemons/data/repositories/pokemon_repository_imbl.dart';
import 'features/pokemons/domain/repositories/pokemons_repository.dart';
import 'features/pokemons/domain/use_cases/get_pokemons_page.dart';
import 'features/pokemons/presentation/manager/pokemons_cubit.dart';
import 'features/splash/presentation/manager/splash_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
///! Features - splash
// Bloc
  sl.registerFactory(() => SplashCubit());

///! Features - auth

// Bloc
  sl.registerFactory(() => AuthCubit(loginUseCase: sl() ));

// Usecases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

// Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      localDataSource: sl(),));

// Datasources
  sl.registerLazySingleton<AuthLocalDataSource>(
          () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

///! Features - pokemons
// Bloc
  sl.registerFactory(() => PokemonsCubit(getPokemonsPageUseCase: sl() ));

// Usecases
  sl.registerLazySingleton(() => GetPokemonsPageUseCase(sl()));

// Repository
  sl.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(
    remoteDataSource: sl(),networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
          () => PokemonRemoteDataSourceImpl(client: sl()));

///! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => dio.Dio());
  sl.registerLazySingleton(() => Connectivity());
}

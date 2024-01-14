import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/pokemon_page.dart';
import '../../domain/repositories/pokemons_repository.dart';
import '../data_sources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl extends PokemonRepository{
  final PokemonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl(
      {required this.remoteDataSource,
        required this.networkInfo});

  @override
  Future<Either<Failure, PokemonPage>> getPokemons({String? path}) async{
    if (await networkInfo.isConnected) {
      try {
        final poke = await remoteDataSource.getPokemons(path: path);
        return Right(poke);
      } on ServerException {
        return Left(ServerFailure());
      } on UnknownException{
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}
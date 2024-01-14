import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/pokemon_page.dart';

abstract class PokemonRepository{
  Future<Either<Failure, PokemonPage>> getPokemons({String? path});
}
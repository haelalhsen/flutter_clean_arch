import 'package:dartz/dartz.dart';
import 'package:test_clean_arch/features/pokemons/domain/repositories/pokemons_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/pokemon_page.dart';

class GetPokemonsPageUseCase{
  final PokemonRepository pokemonRepository;
  GetPokemonsPageUseCase(this.pokemonRepository);

  Future<Either<Failure, PokemonPage>> call({String? path}) async{
    return await pokemonRepository.getPokemons(path: path);
  }
}
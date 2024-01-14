import 'package:equatable/equatable.dart';

import 'pokemon.dart';

class PokemonPage extends Equatable{
  final int count;
  final String next;
  final String? previous;
  final List<Pokemon> pokemons;

  const PokemonPage(
      {required this.count,
      required this.next, this.previous,
      required this.pokemons});

  @override
  // TODO: implement props
  List<Object?> get props => [count,next,previous,pokemons];
}


import '../../domain/entities/pokemon_page.dart';
import 'pokemon_model.dart';

class PokemonPageModel extends PokemonPage {
  const PokemonPageModel(
      {required super.count,
      required super.next,
        super.previous,
      required super.pokemons});

  factory PokemonPageModel.fromJson(Map<String, dynamic> json) {
    List<PokemonModel> poks = [];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        poks.add(PokemonModel.fromJson(v));
      });
    }
    return PokemonPageModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      pokemons: poks,
    );
  }
}

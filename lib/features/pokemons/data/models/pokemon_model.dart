import 'package:test_clean_arch/features/pokemons/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon{
  PokemonModel({required super.name, required super.url});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    String link = getPokemonImage(json['url']);
    return PokemonModel(name: json['name'],url: link);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }

  static String getPokemonImage(String url) {
    final strs = url.split('/');
    String link = 'https://raw.githubusercontent.com/PokeAPI/sprites/'
        'master/sprites/pokemon/other/'
        'official-artwork/${strs.elementAt(strs.length - 2)}.png';
    return link;
  }
}
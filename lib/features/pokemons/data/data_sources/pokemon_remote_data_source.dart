
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/pokemons_page_model.dart';
import 'package:dio/dio.dart' as dio;

abstract class PokemonRemoteDataSource{
  Future<PokemonPageModel> getPokemons({String? path});
}

class PokemonRemoteDataSourceImpl extends PokemonRemoteDataSource{
  dio.Dio client = dio.Dio();
  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<PokemonPageModel> getPokemons({String? path}) async{
    try {
      final String url = path ?? Endpoints.POKEMON_BASE_URL;
      final response = await client.get(url,);
      if (response.statusCode == 200) {
        return PokemonPageModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
     throw UnknownException();
    }
  }

}
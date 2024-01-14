import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_clean_arch/features/pokemons/domain/entities/pokemon_page.dart';

import '../../../../config/strings/failures.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/use_cases/get_pokemons_page.dart';

part 'pokemons_state.dart';

class PokemonsCubit extends Cubit<PokemonsState> {
  final GetPokemonsPageUseCase getPokemonsPageUseCase;

  static PokemonsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  PokemonsCubit({required this.getPokemonsPageUseCase})
      : super(PokemonsInitial());

  PokemonPage? pokemonPage;
  List<Pokemon> pokemonList = [];

  Future<void> listenForPokemons() async {
    emit(PokemonsLoading());
    getPokemonsPageUseCase().then((response) {
      response.fold(
          (failure) =>
              emit(PokemonsError(message: _mapFailureToMessage(failure))),
          (pokePage) {
        pokemonList.addAll(pokePage.pokemons);
        pokemonPage = pokePage;
        if (pokemonList.isEmpty) {
          emit(PokemonsEmpty(message: EMPTY_CACHE_FAILURE_MESSAGE));
        } else {
          emit(PokemonsDataLoaded(pokePage: pokePage));
        }
      });
    });
  }
  Future<void> listenForMorePokemons() async {
    emit(PokemonsLoadingMore());
    getPokemonsPageUseCase(path: pokemonPage!.next).then((response) {
      response.fold(
              (failure) =>
              emit(PokemonsLoadingMoreError(message: _mapFailureToMessage(failure))),
              (pokePage) {
            pokemonList.addAll(pokePage.pokemons);
            pokemonPage = pokePage;
            emit(PokemonsDataLoaded(pokePage: pokePage));
          });
    });
  }

  Future<void> refreshPage() async {
    pokemonList = [];
    listenForPokemons();
  }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}

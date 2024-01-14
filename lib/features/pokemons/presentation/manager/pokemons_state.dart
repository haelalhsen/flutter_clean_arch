part of 'pokemons_cubit.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();
}

class PokemonsInitial extends PokemonsState {
  @override
  List<Object> get props => [];
}
class PokemonsLoading extends PokemonsState {
  @override
  List<Object> get props => [];
}
class PokemonsLoadingMore extends PokemonsState {
  @override
  List<Object> get props => [];
}
class PokemonsDataLoaded extends PokemonsState {
  final PokemonPage pokePage;
  PokemonsDataLoaded({required this.pokePage});
  @override
  List<Object> get props => [pokePage];
}
class PokemonsError extends PokemonsState {
  final String message;

  PokemonsError({required this.message});

  @override
  List<Object> get props => [message];
}
class PokemonsEmpty extends PokemonsState {
  final String message;

  PokemonsEmpty({required this.message});

  @override
  List<Object> get props => [message];
}
class PokemonsLoadingMoreError extends PokemonsState {
  final String message;

  PokemonsLoadingMoreError({required this.message});

  @override
  List<Object> get props => [message];
}


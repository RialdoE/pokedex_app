import 'package:equatable/equatable.dart';
import 'package:pokedex_app/models/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<PokemonModel> pokemons;
  final bool hasMore;

  const PokemonLoaded({required this.pokemons, required this.hasMore});

  @override
  List<Object?> get props => [pokemons, hasMore];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object?> get props => [message];
}

//States for detail page
class PokemonDetailLoading extends PokemonState {}

class PokemonDetailLoaded extends PokemonState {
  final PokemonModel pokemon;

  const PokemonDetailLoaded(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}

class PokemonDetailError extends PokemonState {
  final String message;

  const PokemonDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

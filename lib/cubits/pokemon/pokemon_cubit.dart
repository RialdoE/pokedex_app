import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/cubits/pokemon/pokemon_state.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final PokemonRepository _pokemonRepository;

  final List<PokemonModel> _allPokemons = [];
  List<String> _allPokemonNames = [];
  int _offset = 0;

  PokemonCubit(this._pokemonRepository) : super(PokemonInitial());

  Future<void> getPokemon() async {
    if (state is PokemonLoading) return; //Dont get when we are still loaing

    if (state is PokemonLoaded && !(state as PokemonLoaded).hasMore) {
      return; //Dont get when all the pokemon has already been loaded
    }

    if (_allPokemons.isEmpty) {
      emit(PokemonLoading());
    }

    try {
      final newPokemons = await _pokemonRepository.getPokemon(_offset);
      _offset += newPokemons.length;
      _allPokemons.addAll(newPokemons);

      emit(
        PokemonLoaded(
          pokemons: List.from(_allPokemons),
          hasMore: newPokemons.length == PokemonRepository.pageSize,
        ),
      );
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }

  Future<void> searchPokemonByName(String name) async {
    if (name.isEmpty) {
      emit(PokemonLoaded(pokemons: List.from(_allPokemons), hasMore: true));
      return;
    }
    emit(PokemonLoading());

    try {
      final pokemon = await _pokemonRepository.searchPokemonByName(name);

      if (pokemon == null) {
        emit(const PokemonError('No Pokémon found with that name'));
      } else {
        emit(PokemonLoaded(pokemons: [pokemon], hasMore: false));
      }
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }

  Future<void> loadAllPokemonNames() async {
    try {
      _allPokemonNames = await _pokemonRepository.getAllPokemonNames();
    } catch (e) {
      //This is not critical the app will not stop functioning if this fails
    }
  }

  List<String> getSuggestedPokemon(String query) {
    if (query.isEmpty) return [];
    return _allPokemonNames
        .where((name) => name.toLowerCase().startsWith(query.toLowerCase()))
        .take(5)
        .toList();
  }

  Future<void> getPokemonDetail(int id) async {
    emit(PokemonDetailLoading());
    try {
      final pokemon = await _pokemonRepository.getPokemonDetail(id);
      emit(PokemonDetailLoaded(pokemon));
    } catch (e) {
      emit(PokemonDetailError(e.toString()));
    }
  }
}

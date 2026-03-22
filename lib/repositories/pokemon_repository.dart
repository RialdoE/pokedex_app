import 'dart:convert';

import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  static const int pageSize = 20;

  Future<List<PokemonModel>> getPokemon(int offset) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pokemon?limit=$pageSize&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      return results.map((pokemon) {
        final url = pokemon['url'] as String;
        final id = int.parse(url.split('/').where((s) => s.isNotEmpty).last);

        return PokemonModel(
          id: id,
          name: pokemon['name'],
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
        );
      }).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<PokemonModel?> searchPokemonByName(String name) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pokemon/${name.toLowerCase().trim()}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final id = data['id'] as int;
      return PokemonModel(
        id: id,
        name: data['name'],
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      );
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to to find Pokémon');
    }
  }

  Future<List<String>> getAllPokemonNames() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pokemon?limit=2000&offset=0'),
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((pokemon) => pokemon['name'] as String).toList();
    } else {
      throw Exception('Failed to load Pokémon names');
    }
  }

  Future<PokemonModel> getPokemonDetail(int id) async {
    final results = await Future.wait([
      http.get(Uri.parse('$_baseUrl/pokemon/$id')),
      http.get(Uri.parse('$_baseUrl/pokemon-species/$id')),
    ]);

    final pokemonResponse = results[0];
    final speciesResponse = results[1];

    if(pokemonResponse.statusCode == 200 && speciesResponse.statusCode == 200) {
      final pokemonData = jsonDecode(pokemonResponse.body);
      final speciesData = jsonDecode(speciesResponse.body);

      final List flavorEntries = speciesData['flavor_text_entries'];
      final description = flavorEntries.firstWhere(
        (e) => e['language']['name'] == 'en',
        orElse: () => {'flavor_text' : 'No description available'},
      )['flavor_text'].toString().replaceAll('\n', ' ').replaceAll('\f', ' ');

      final List types = pokemonData['types'];
      final typeNames = types.map((t) => t['type']['name'] as String).toList();

      final List stats = pokemonData['stats'];
      int getStat(String name) => 
        stats.firstWhere((s) => s['stat']['name'] == name)['base_stat'] as int;

        return PokemonModel(
          id: id,
          name: pokemonData['name'],
          imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
          description: description,
          types: typeNames,
          hp: getStat('hp'),
          attack: getStat('attack'),
          defence: getStat('defense'),
          speed: getStat('speed'),
          specialAttack: getStat('special-attack'),
          specialDefence: getStat('special-defense'),
        );
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }
}

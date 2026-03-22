import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/cubits/favourite/favourite_cubit.dart';
import 'package:pokedex_app/cubits/favourite/favourite_state.dart';
import 'package:pokedex_app/cubits/pokemon/pokemon_cubit.dart';
import 'package:pokedex_app/cubits/pokemon/pokemon_state.dart';
import 'package:pokedex_app/repositories/favourite_repository.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';
import 'package:pokedex_app/themes.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;
  final String pokemonName;

  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => 
            PokemonCubit(PokemonRepository(), FavouriteRepository())..getPokemonDetail(pokemonId),
        ),
        BlocProvider(
          create: (_) => 
            FavouriteCubit(FavouriteRepository())..getFavourites(FirebaseAuth.instance.currentUser!.uid),
        )
      ],
      child: _PokemonDetailContent(
        pokemonId: pokemonId,
        pokemonName: pokemonName,
      ),
    ); 
  }
}

class _PokemonDetailContent extends StatelessWidget {
  final int pokemonId;
  final String pokemonName;

  const _PokemonDetailContent({required this.pokemonId, required this.pokemonName});

  Widget _buildStatRow(String label, int? value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              value?.toString() ?? '-',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (value ?? 0) / 255,
                backgroundColor: Colors.grey.shade300,
                color: color,
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemonName[0].toUpperCase() + pokemonName.substring(1),
          style: TextStyle(
            color: AppColors.pokemonWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.pokemonRed,
        iconTheme: const IconThemeData(color: AppColors.pokemonWhite),
        actions: [
          BlocBuilder<FavouriteCubit,FavouriteState>(
            builder: (context, state) {
              final isFavourite = context.read<FavouriteCubit>().isFavourite(pokemonId);

              if(state is FavouriteLoading) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(
                    color: AppColors.pokemonWhite,
                  ),
                );
              }
              return IconButton(
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.pokemonWhite,
                  ),                
                  onPressed: () => context.read<FavouriteCubit>().toggleFavourites(userId, pokemonId),
              );
            },
            )
        ],
      ),
      body: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          if (state is PokemonDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.pokemonRed),
            );
          }

          if (state is PokemonDetailError) {
            return Center(child: Text(state.message));
          }

          if (state is PokemonDetailLoaded) {
            final pokemon = state.pokemon;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Image.network(pokemon.imageUrl, height: 200)),
                  const SizedBox(height: 16),

                  if (pokemon.types != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pokemon.types!
                          .map(
                            (type) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.pokemonRed,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                type[0].toUpperCase() + type.substring(1),
                                style: const TextStyle(
                                  color: AppColors.pokemonWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                  const SizedBox(height: 16),

                  if(pokemon.description != null)
                    Text(
                      pokemon.description!,
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Base Stats',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _buildStatRow('HP', pokemon.hp, Colors.green),
                    _buildStatRow('Attack', pokemon.attack, Colors.red),
                    _buildStatRow('Defence', pokemon.defence, Colors.blue),
                    _buildStatRow('Sp. Attack', pokemon.specialAttack, Colors.orange),
                    _buildStatRow('Sp. Defence', pokemon.specialDefence, Colors.purple),
                    _buildStatRow('Speed', pokemon.speed, Colors.yellow),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

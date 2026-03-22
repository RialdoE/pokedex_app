import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/cubits/pokemon/pokemon_cubit.dart';
import 'package:pokedex_app/cubits/pokemon/pokemon_state.dart';
import 'package:pokedex_app/pages/pokemon_detail_page.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';
import 'package:pokedex_app/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonCubit(PokemonRepository())
        ..getPokemon()
        ..loadAllPokemonNames(),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PokemonCubit>().getPokemon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PokéDex',
          style: TextStyle(
            color: AppColors.pokemonWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.pokemonRed,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return context.read<PokemonCubit>().getSuggestedPokemon(
                  textEditingValue.text,
                );
              },
              onSelected: (String selection) {
                _searchController.text = selection;
                context.read<PokemonCubit>().searchPokemonByName(selection);
              },
              fieldViewBuilder: (context, controller, focusnode, onsubmitted) {
                controller.addListener(() {
                  _searchController.text = controller.text;
                });
                return StatefulBuilder(
                  builder: (context, setState) {
                    controller.addListener(() => setState(() {}));
                    return TextFormField(
                      controller: controller,
                      focusNode: focusnode,
                      decoration: InputDecoration(
                        labelText: 'Search Pokémon...',
                        suffixIcon: controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  controller.clear();
                                  _searchController.clear();
                                  context
                                      .read<PokemonCubit>()
                                      .searchPokemonByName('');
                                },
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                if (state is PokemonLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.pokemonRed,
                    ),
                  );
                }

                if (state is PokemonError) {
                  return Center(child: Text(state.message));
                }

                if (state is PokemonLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.pokemons.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.pokemons.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              color: AppColors.pokemonRed,
                            ),
                          ),
                        );
                      }
                      final pokemon = state.pokemons[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PokemonDetailPage(pokemonId: pokemon.id, pokemonName: pokemon.name),
                            )
                          ),
                          leading: Image.network(
                            pokemon.imageUrl,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            pokemon.name[0].toUpperCase() +
                                pokemon.name.substring(1),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

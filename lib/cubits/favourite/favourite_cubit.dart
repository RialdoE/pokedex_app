import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/cubits/favourite/favourite_state.dart';
import 'package:pokedex_app/repositories/favourite_repository.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepository _favouriteRepository;

  List<int> _favouriteIds = [];

  FavouriteCubit(this._favouriteRepository) : super(FavouriteInitial());

  Future<void> getFavourites(String userId) async {
    emit(FavouriteLoading());

    try {
      _favouriteIds = await _favouriteRepository.getFavourites(userId);
      emit(FavouriteLoaded(List.from(_favouriteIds)));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleFavourites(String userId, int pokemonId) async {
    emit(FavouriteLoading());
    try {
      await _favouriteRepository.toggleFavourites(userId, pokemonId);

      if (_favouriteIds.contains(pokemonId)) {
        _favouriteIds.remove(pokemonId);
      } else {
        _favouriteIds.add(pokemonId);
      }
      emit(FavouriteLoaded(List.from(_favouriteIds)));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  bool isFavourite(int pokemonId) {
    return _favouriteIds.contains(pokemonId);
  }
}

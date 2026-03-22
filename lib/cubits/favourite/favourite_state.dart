import 'package:equatable/equatable.dart';

abstract class FavouriteState extends Equatable{
  const FavouriteState();

  @override
  List<Object?> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<int> favouriteIds;

  const FavouriteLoaded(this.favouriteIds);

  @override
  List<Object?> get props => [favouriteIds];
}

class FavouriteError extends FavouriteState {
  final String message;

  const FavouriteError(this.message);

  @override
  List<Object?> get props => [message];
}
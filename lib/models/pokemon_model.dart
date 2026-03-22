
import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String? description;
  final List<String>? types;
  final int? hp;
  final int? attack;
  final int? defence;
  final int? speed;
  final int? specialAttack;
  final int? specialDefence;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    this.types,
    this.hp,
    this.attack,
    this.defence,
    this.speed,
    this.specialAttack,
    this.specialDefence,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    description,
    types,
    hp,
    attack,
    defence,
    speed,
    specialAttack,
    specialDefence,
  ];
}

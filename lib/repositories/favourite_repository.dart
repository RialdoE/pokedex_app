import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteRepository {
  final _firestore = FirebaseFirestore.instance;

  DocumentReference _userDoc(String userId) => 
    _firestore.collection('users').doc(userId);

    Future<List<int>> getFavourites(String userId) async {
      final doc = await _userDoc(userId).get();

      if(doc.exists){
        final data = doc.data() as Map<String, dynamic>;
        final List favourites = data['favourites'] ?? [];
        return favourites.map((id) => id as int).toList();
      }
      return [];
    }

    Future<void> toggleFavourites(String userId, int pokemonId) async {
      final favourites = await getFavourites(userId);

      if(favourites.contains(pokemonId)) {
        await _userDoc(userId).update({
          'favourites': FieldValue.arrayRemove([pokemonId]),
        });
      } else {
        await _userDoc(userId).set({
          'favourites': FieldValue.arrayUnion([pokemonId]),
        }, SetOptions(merge: true));
      }
    }

    Future<bool> isFavourite(String userId, int pokemonId) async {
      final favourites = await getFavourites(userId);
      return favourites.contains(pokemonId);
    }
}
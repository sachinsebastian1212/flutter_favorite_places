import 'dart:io';

import 'package:flutter_favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String place,File image) {
    final newPlace = Place(title: place, image: image,);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier,List<Place>>(
  (ref) => UserPlacesNotifier(),
);

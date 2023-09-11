import 'package:equatable/equatable.dart';

import '../model/address.dart';

class FavoritePlaceState extends Equatable{
  @override
  List<Object?> get props => [];
}

class FavoritePlaceInitial extends FavoritePlaceState {}

class FavoritePlaceLoading extends FavoritePlaceState {}

class FavoritePlaceLoaded extends FavoritePlaceState {
  final List places;

  FavoritePlaceLoaded(this.places);
}
class FavoritePlaceLoadedNodata extends FavoritePlaceState {
  final String message;
  FavoritePlaceLoadedNodata({required this.message});
}
class FavoritePlaceUpdateSuccess extends FavoritePlaceState {
  final String message;
  FavoritePlaceUpdateSuccess({required this.message});
}
class FavoritePlaceUpdateFaild extends FavoritePlaceState {
  final String message;
  FavoritePlaceUpdateFaild({required this.message});
}

class FavoritePlaceDeleteFaild extends FavoritePlaceState {
  final String message;
  FavoritePlaceDeleteFaild({required this.message});
}

class FavoritePlaceDeleteSucesss extends FavoritePlaceState {
  final String message;
  FavoritePlaceDeleteSucesss({required this.message});
}
class FavoritePlaceFetchData extends FavoritePlaceState {
  List<Address> addresses;
  FavoritePlaceFetchData({
    required this.addresses,
  });
  
}

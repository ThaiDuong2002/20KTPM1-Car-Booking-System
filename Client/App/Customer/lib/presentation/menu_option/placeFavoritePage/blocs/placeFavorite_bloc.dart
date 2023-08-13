import 'package:bloc/bloc.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/blocs/placeFavorite_event.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/blocs/placeFavorite_state.dart';

class FavoritePlaceBloc extends Bloc<PlaceFavoriteEvent, FavoritePlaceState> {
  FavoritePlaceBloc() : super(FavoritePlaceInitial()) {
    on<PlacePressUpdate>(updateLocation);
  }
  void updateLocation(PlacePressUpdate event, Emitter emit) {
    emit(FavoritePlaceLoading());
    try {
      emit(FavoritePlaceUpdateSuccess(message: "Update success"));
    } catch (e) {
      emit(FavoritePlaceUpdateFaild(message: "Update faild"));
    }
  }
}

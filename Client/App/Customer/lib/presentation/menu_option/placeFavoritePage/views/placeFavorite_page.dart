import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/blocs/placeFavorite_bloc.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/blocs/placeFavorite_event.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/views/placeFavorite_view.dart';

class PlaceFavoritePage extends StatelessWidget {
  const PlaceFavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: BlocProvider(
      create: (context) => FavoritePlaceBloc()..add(PlacePressFetchData()),
      child: PlaceFavoriteView(),
    ));
  }
}

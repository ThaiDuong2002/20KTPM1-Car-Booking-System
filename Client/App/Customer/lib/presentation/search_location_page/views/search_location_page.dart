import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/search_location_page/blocs/search_location_bloc.dart';
import 'package:user/presentation/search_location_page/views/search_location_view.dart';



class SearchLocationPage extends StatelessWidget {
  const SearchLocationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => SearchLocationBloc(),
        child: SearchLocationView(),
      ),
    );
  }
}

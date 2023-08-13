import 'package:equatable/equatable.dart';
import 'package:user/domain/search_location/entity/item_search_entity.dart';

class SearchLocationState extends Equatable {
  const SearchLocationState();
  @override
  List<Object?> get props => [];
}

class SearchLocationStateInitial extends SearchLocationState {}

class SearchLocationStateLoading extends SearchLocationState {
  
}

class SearchLocationStateSuccess extends SearchLocationState {
  final List<ItemSearchEntity> searchEntities; 
  SearchLocationStateSuccess({
    required this.searchEntities,
  });
  
}

class SearchLocationStateFailure extends SearchLocationState {
  final String message;
  const SearchLocationStateFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

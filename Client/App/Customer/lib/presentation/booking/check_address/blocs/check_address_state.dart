import 'package:equatable/equatable.dart';

import '../../../../domain/search_location/entity/item_search_entity.dart';

class CheckAddressState extends Equatable {
  const CheckAddressState();

  @override
  List<Object> get props => [];
}

class CheckAddressStateInitial extends CheckAddressState {}
class CheckAddressStateLoading extends CheckAddressState {}
class CheckAddressStateSuccess extends CheckAddressState {
  final List<ItemSearchEntity> searchEntities;
  CheckAddressStateSuccess({
    required this.searchEntities,
  });
 
}
class CheckAddressStateFailure extends CheckAddressState {
  final String message;
  CheckAddressStateFailure({
    required this.message,
  });
  
}

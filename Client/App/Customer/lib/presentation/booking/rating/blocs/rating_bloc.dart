import 'package:bloc/bloc.dart';
import 'package:user/presentation/booking/rating/blocs/rating_event.dart';
import 'package:user/presentation/booking/rating/blocs/rating_state.dart';

class RatingBloc extends Bloc<RatingEvent,RatingState>{
  RatingBloc() : super(RatingStateInitial());

 
}
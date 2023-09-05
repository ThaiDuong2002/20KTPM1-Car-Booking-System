import 'package:equatable/equatable.dart';

class RatingState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class RatingStateInitial extends RatingState{}
class RatingStateLoading extends RatingState{}
class RatingStateSuccess extends RatingState{
  final String message;
  RatingStateSuccess({required this.message});
}
class RatingStateFailure extends RatingState{
  final String message;
  RatingStateFailure({required this.message});
}
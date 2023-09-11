import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}
class ChatStateInitial extends ChatState {}
class ChatStateLoading extends ChatState {}
class ChatStateSuccess extends ChatState {
  final String message;

  const ChatStateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
class ChatStateFailure extends ChatState {}

class ChatStateSending extends ChatState {
  final String message;

  const ChatStateSending({required this.message});

  @override
  List<Object> get props => [message];
}
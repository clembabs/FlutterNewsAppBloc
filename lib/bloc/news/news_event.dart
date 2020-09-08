import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class GetNewsList extends NewsEvent {
  @override
  List<Object> get props => null;
}

class GetNewsEverything extends NewsEvent {
  @override
  List<Object> get props => null;
}
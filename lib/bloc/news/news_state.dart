import 'package:equatable/equatable.dart';
import 'package:newsapp_bloc/model/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  const NewsInitial();
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  const NewsLoading();
  @override
  List<Object> get props => null;
}

class NewsLoaded extends NewsState {
  final ArticleModel articleModel;
  const NewsLoaded(this.articleModel);
  @override
  List<Object> get props => [articleModel];
}

class NewsError extends NewsState {
  final String message;
  const NewsError(this.message);
  @override
  List<Object> get props => [message];
}
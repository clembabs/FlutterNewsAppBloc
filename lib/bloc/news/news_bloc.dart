import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_bloc/bloc/news/bloc.dart';
import 'package:newsapp_bloc/repository/NewsRepository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  NewsState get initialState => NewsInitial();
  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetNewsList) {
      try {
        yield NewsLoading();
        final mList = await _apiRepository.getTopHeadlines();
        yield NewsLoaded(mList);
        if (mList.error != null) {
          yield NewsError(mList.error);
        }
      } on NetworkError {
        yield NewsError("Failed to fetch data. is your device online?");
      }
    }
    if (event is GetNewsEverything) {
      try {
        yield NewsLoading();
        final nList = await _apiRepository.getEverything();
        yield NewsLoaded(nList);
        if (nList.error != null && nList.error !=null) {
          yield NewsError(nList.error);
        }
      } on NetworkError {
        yield NewsError("Failed to fetch data. is your device online?");
      }
    }
  }
}
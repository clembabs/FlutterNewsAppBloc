import 'package:newsapp_bloc/model/article.dart';
import 'package:newsapp_bloc/repository/newsApi.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ArticleModel> getTopHeadlines() {
    return  _provider.getTopHeadlines();
     
  }
  Future<ArticleModel> getEverything() {
    return  _provider.getEverything();
     
  }
}

class NetworkError extends Error {}
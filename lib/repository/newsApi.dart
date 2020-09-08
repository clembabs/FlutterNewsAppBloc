 
import 'package:dio/dio.dart';
import 'package:newsapp_bloc/model/article.dart';

class ApiProvider {
  
  final String _baseurl = 'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
  final String _everythingUrl ="https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey";
  static String country = "ng";
  static String apiKey = "3b5501605550459a818a205a8d6ffc6f";


final Dio _dio = Dio();
  Future<ArticleModel> getTopHeadlines() async {
    try {
      Response response = await _dio.get(_baseurl);
      return ArticleModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleModel.withError("Data not found / Connection issue");
    }
  }

  Future<ArticleModel> getEverything() async {
    try {
      Response response = await _dio.get(_everythingUrl);
      return ArticleModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleModel.withError("Data not found / Connection issue");
    }
  }
}


// class ApiProvider {
  
//   static String _baseurl = 'https://newsapi.org/v2/';
//   final String apiKey = "";
// final Dio _dio = Dio();

// var getSourcesUrl ="$_baseurl/sources";
// var getTopHeadlinesUrl ="$_baseurl/top-headlines";
// var everythingUrl ="$_baseurl/everything";

// // Future<SourceResponse> getSources() async {
// //   var params = {
// //     "apiKey": apiKey,
// //     "language": "en",
// //     "country": "ng"
// //   };
// //   try {
// //     Response response = await _dio.get(getSourcesUrl, queryParameters: params);
// //     return SourceResponse.fromJson(response.data);

// //   } catch (error, stacktrace) {
// //     print("Exception occured: $error stackTrace: $stacktrace");
// //     return SourceResponse.withError(error);
// //   }
// // }


// Future<ArticleResponse> getTopHeadlines() async {
//   var params = {
//     "apiKey": apiKey,
//     "country": "ng"
//   };
//   try {
//     Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
//     return ArticleResponse.fromJson(response.data);
//   } catch (error, stacktrace) {
//     print("Exception occured: $error stackTrace: $stacktrace");
//     return ArticleResponse.withError(error);
//   }
// }

// Future<ArticleResponse> getHotNews() async {
//   var params = {
//     "apiKey": apiKey,
//     "q": "apple",
//     "sortBy": "popularity"
//   };
//   try {
//     Response response = await _dio.get(everythingUrl, queryParameters: params);
//     return ArticleResponse.fromJson(response.data);
//   } catch (error, stacktrace) {
//     print("Exception occured: $error stackTrace: $stacktrace");
//     return ArticleResponse.withError(error);
//   }
// }

// }
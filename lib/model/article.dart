class ArticleModel {
  List<Articles> articles;
  String error;
  ArticleModel({this.articles, this.error});

  ArticleModel.withError(String errorMessage) {
    error = errorMessage;
  }

  ArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = List<Articles>();
      json['articles'].forEach((v) {
        articles.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
      return data;
    }
  }
}

class Articles {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String date;
  String content;

  Articles(this.author, this.title, this.description, this.url, this.urlToImage,
      this.date, this.content);

  Articles.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    title = json["title"];
    description = json["description"];
    url = json["url"];
    urlToImage = json["urlToImage"];
    date = json["publishedAt"];
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.date;
    data['content'] = this.content;
  }
}

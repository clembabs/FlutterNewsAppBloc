import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_bloc/bloc/authentication/bloc.dart';
import 'package:newsapp_bloc/bloc/news/bloc.dart';
import 'package:newsapp_bloc/model/article.dart';
import 'package:newsapp_bloc/screens/news/news_details.dart';
import 'package:newsapp_bloc/widgets/loading.dart';

class NewsPage extends StatefulWidget {
  final User user;

  const NewsPage({Key key, this.user}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsBloc _newsBloc = NewsBloc(NewsInitial());
  final NewsBloc _bloc = NewsBloc(NewsInitial());
  bool loading = false;

  @override
  void initState() {
    _newsBloc.add(GetNewsList());
    _bloc.add(GetNewsEverything());
    super.initState();
  }

  @override
  void setState(fn) {
    loading = true;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NewsApp'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            )
          ],
        ),
        body: loading
            ? _buildLoading() != null
            : ListView(
                children: [
                  _buildHeadlinesSlider(),
                  _buildListNews(),
                ],
              ));
  }

  Widget _buildHeadlinesSlider() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsInitial) {
                return _buildLoading();
              } else if (state is NewsLoading) {
                return _buildLoading();
              } else if (state is NewsLoaded) {
                return _buildSlider(context, state.articleModel);
              } else if (state is NewsError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListNews() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsInitial) {
                return _buildLoading();
              } else if (state is NewsLoading) {
                return _buildLoading();
              } else if (state is NewsLoaded) {
                return _buildCard(context, state.articleModel);
              } else if (state is NewsError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, ArticleModel model) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Top News",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: model.articles.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetail(
                                    urlToImage:
                                        model.articles[index].urlToImage,
                                    title: model.articles[index].title,
                                    content: model.articles[index].content,
                                    date: model.articles[index].date,
                                    author: model.articles[index].author,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(-2, -1),
                                blurRadius: 5),
                          ]),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(children: [
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Loading(),
                              )),
                              Center(
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage("assets/n-logo-border.png"),
                                  image: NetworkImage(
                                      model.articles[index].urlToImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          model.articles[index].title ?? "",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8),
                        Text(
                          model.articles[index].description ?? "",
                          maxLines: 3,
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: 8),
                      ]),
                    ),
                  ),
                ],
              );
            }),
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildSlider(BuildContext context, ArticleModel model) {
    return CarouselSlider(
      options: CarouselOptions(
          enlargeCenterPage: false, height: 200, viewportFraction: 0.9),
      items: getSlider(model),
    );
  }

  getSlider(ArticleModel model) {
    return model.articles
        .map((article) => GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: article.urlToImage == null
                                    ? AssetImage("assets/n-logo-border.png")
                                    : NetworkImage(article.urlToImage)))),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [
                                  0.1,
                                  0.9
                                ],
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.black.withOpacity(0.8)
                                ]))),
                    Positioned(
                        bottom: 30.0,
                        child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: 250,
                            child: Column(
                              children: [
                                Text(
                                  article.title ?? "",
                                  style: TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ))),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          article.date.substring(0, 10) ?? "",
                          style: TextStyle(color: Colors.white54, fontSize: 9),
                        ))
                  ],
                ),
              ),
            ))
        .toList();
  }
}

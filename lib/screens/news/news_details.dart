import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:newsapp_bloc/widgets/constants.dart';

class NewsDetail extends StatefulWidget {
  final String urlToImage, title, date, content, author;

  const NewsDetail(
      {Key key,
      this.urlToImage,
      this.title,
      this.date,
      this.content,
      this.author})
      : super(key: key);
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          title: AutoSizeText(
            widget.title ?? "",
            maxLines: 1,
            style: TextStyle(fontSize: 14),
          )),
      body: ListView(children: [
        Container(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/main_top.png",
                      image: widget.urlToImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                widget.title ?? "Top news",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                widget.author ?? "",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                widget.date.substring(0, 10) ?? "",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Text(
                widget.content ?? "No Content available",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}

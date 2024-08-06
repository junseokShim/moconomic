import 'package:flutter/material.dart';
import '../models/news_item.dart';

class NewsListView extends StatelessWidget {
  final List<NewsItem> newsItems;

  const NewsListView({
    super.key,
    required this.newsItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        NewsItem news = newsItems[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(news.title),
            subtitle: Text(news.summary.split('\n')[0].split('. ')[0]),
            onTap: () {
              _showSummaryPopup(context, news.title, news.summary);
            },
          ),
        );
      },
    );
  }

  void _showSummaryPopup(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: SelectableText(title),
              content: SelectableText(content),
              actions: <Widget>[
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }
}

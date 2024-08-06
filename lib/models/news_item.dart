class NewsItem {
  final String title;
  final String summary;
  final String url;
  final String? type;

  var date;

  NewsItem(
      {required this.date,
      required this.title,
      required this.summary,
      required this.url,
      required this.type});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        date: json['date'],
        title: json['title'],
        summary: json['summary'],
        url: json['url'],
        type: json['type']);
  }
}

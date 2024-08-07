import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_item.dart';
import '../models/report_item.dart';

class NewsService {
  Future<List<NewsItem>> fetchNews() async {
    //final response = await http.get(Uri.parse('http://0.0.0.0:8000/news'));

    // server
    // await http.get(Uri.parse('http://59.21.133.140:8000/news'));
    // final response =
    //     await http.get(Uri.parse('http://59.21.133.140:8000/news'));

    // // phone build 192.168.219.100
    final response =
        await http.get(Uri.parse('http://14.43.161.199:8000/news'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => NewsItem.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

Future<List<ReportItem>> fetchDailyReports() async {
  final response =
      await http.get(Uri.parse('http://14.43.161.199:8000/daily_reports'));

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => ReportItem.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load reports');
  }
}

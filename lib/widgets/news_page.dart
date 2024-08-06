import 'package:flutter/material.dart';

import '../services/news_service.dart';
import '../widgets/tab_bar_list.dart';
import '../widgets/news_list_view.dart';
import '../models/news_item.dart';
import '../widgets/common_app_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  late Future<List<NewsItem>> futureNews;
  late TabController _tabController;
  String? currentTab = "latest-news";

  final NewsService newsService = NewsService();

  @override
  void initState() {
    super.initState();
    futureNews = newsService.fetchNews();
    _tabController = TabController(length: 3, vsync: this); // 탭의 개수와 vsync 설정
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        switch (_tabController.index) {
          case 0:
            currentTab = "latest-news";
            break;
          case 1:
            currentTab = "economic-news";
            break;
          case 2:
            currentTab = "crypto";
            break;
        }
      });
    }
  }

  void refreshNews() {
    futureNews = newsService.fetchNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: titleName('Summaried News !!'),
        actions: <Widget>[
          IconButton(
            onPressed: refreshNews,
            icon: const Icon(Icons.refresh),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 150, 207, 254),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabBarList,
        ),
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: futureNews,
        builder: filterSnapShotData,
      ),
    );
  }

  Widget filterSnapShotData(context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('${snapshot.error}'));
    } else if (snapshot.hasData) {
      var filteredNews =
          snapshot.data!.where((item) => item.type == currentTab).toList();
      return NewsListView(
        newsItems: filteredNews,
      );
    } else {
      return const Center(child: Text('No data available'));
    }
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:moconomic/models/news_item.dart';
import 'package:moconomic/widgets/economic_study.dart';
import 'package:moconomic/widgets/news_page.dart';

import '../widgets/common_app_bar.dart';
import '../widgets/page_card.dart';
import '../widgets/content_card.dart';
import '../widgets/report_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<String> todayEconomicMessage;
  final String todayEconomicMessageTitle = "오늘의 경제 한마디";
  final String goToNewsPaper = "경제 뉴스 요약 페이지";
  final String todayEconomicStudy = "오늘의 경제 공부";
  final String summariedNews = "일일 경제 보고서";

  @override
  void initState() {
    super.initState();
    todayEconomicMessage = EconomicMessage.getEconomicMessage();
  }

  Widget getEconomicMessage(String message) {
    return Text(message);
  }

  void refreshPage() {
    todayEconomicMessage = EconomicMessage.getEconomicMessage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: titleName('Today News'),
        backgroundColor: const Color.fromARGB(255, 150, 207, 254),
        actions: <Widget>[
          IconButton(
            onPressed: refreshPage,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ContentCard(todayEconomicMessageTitle, Icons.attach_money_sharp),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: todayEconomicMessage,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                              color: const Color.fromARGB(95, 202, 202, 202),
                              width: 1)),
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(
                              snapshot.data!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '- 워렌 버핏 -',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContentCard(todayEconomicStudy, Icons.book_sharp),
                      const PageCard(
                        name: 'Economic Study',
                        code: '하루에 하나!\n일일 경제공부 ',
                        amount: '',
                        isInverted: true,
                        order: -0.5,
                        function: EconomicStudy(),
                        bgImage: "./assets/book.jpg",
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContentCard(goToNewsPaper, Icons.newspaper_sharp),
                      const PageCard(
                        name: 'Economic News',
                        code: '요약된 국제 경제 뉴스를 \n제공해드립니다',
                        amount: '',
                        isInverted: false,
                        order: -0.5,
                        function: NewsPage(),
                        bgImage: "./assets/chart.png",
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ContentCard("일일 경제 리포트", Icons.summarize),
            const DynamicRows(),
          ],
        ),
      ),
    );
  }
}

class EconomicMessage {
  static Future<String> getEconomicMessage() async {
    return "First rule, Don't lose your money.\nSecond rule, Don't forget the first rule";
  }
}

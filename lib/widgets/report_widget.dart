import 'package:flutter/material.dart';
import 'package:moconomic/widgets/page_popup.dart';
import '../models/report_item.dart';
import '../services/news_service.dart'; // fetchDailyReports 함수가 포함된 파일

class DynamicRows extends StatelessWidget {
  const DynamicRows({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReportItem>>(
      future: fetchDailyReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final reports = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: reports.map((report) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PagePopup(
                      name: report.title,
                      code: "",
                      amount: '',
                      isInverted: true,
                      order: -0.5,
                      function: () => _showSummaryPopup(
                          context, report.title, report.report), // 팝업 표시 함수
                      bgImage: "./assets/report.png",
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }).toList(),
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
            ),
          ],
        );
      },
    );
  }
}

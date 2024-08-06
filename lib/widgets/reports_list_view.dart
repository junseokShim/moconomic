import 'package:flutter/material.dart';
import '../models/report_item.dart';

class ReportListView extends StatelessWidget {
  final List<ReportItem> reportItems;

  const ReportListView({
    super.key,
    required this.reportItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reportItems.length,
      itemBuilder: (context, index) {
        ReportItem report = reportItems[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(report.title),
            subtitle: Text(
              report.report.split('\n')[0].split('. ')[0],
              maxLines: 1, // 최대 한 줄로 제한
              overflow: TextOverflow.ellipsis, // 텍스트가 넘칠 경우 생략 표시
            ),
            onTap: () {
              _showSummaryPopup(context, report.title, report.report);
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
          ],
        );
      },
    );
  }
}

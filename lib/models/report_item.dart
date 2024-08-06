class ReportItem {
  final String title;
  final String report;

  ReportItem({required this.title, required this.report});

  factory ReportItem.fromJson(Map<String, dynamic> json) {
    return ReportItem(
      title: json['title'],
      report: json['report'],
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/common_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플러그인 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EconomicStudy(),
    );
  }
}

class EconomicStudy extends StatefulWidget {
  const EconomicStudy({super.key});

  @override
  _EconomicStudy createState() => _EconomicStudy();
}

class _EconomicStudy extends State<EconomicStudy> {
  List<dynamic>? _economicWords;
  final int _currentId = 1;

  @override
  void initState() {
    super.initState();
    _loadEconomicWords();
    // _loadCurrentId();
  }

  Future<void> _loadEconomicWords() async {
    final String response =
        await rootBundle.loadString('assets/economicStudy/economic_words.json');
    final data = await json.decode(response);
    setState(() {
      _economicWords = data['data'];
    });
  }

  // Future<void> _loadCurrentId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _currentId = (prefs.getInt('currentId') ?? 1);
  //   });
  // }

  // Future<void> _updateCurrentId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _currentId = (_currentId % (_economicWords?.length ?? 1)) + 1;
  //     prefs.setInt('currentId', _currentId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (_economicWords == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: titleName('Economic Study'),
          backgroundColor: const Color.fromARGB(255, 150, 207, 254),
          actions: const <Widget>[],
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentItem =
        _economicWords!.firstWhere((item) => item['id'] == _currentId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: titleName('Economic Study'),
        backgroundColor: const Color.fromARGB(255, 150, 207, 254),
        actions: const <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.refresh),
          //   onPressed: _updateCurrentId,
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentItem['name'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 3),
            const Divider(),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currentItem['content'],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

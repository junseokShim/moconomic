import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/tab_bar_list.dart';

class EconomicStudy extends StatefulWidget {
  const EconomicStudy({super.key});

  @override
  _EconomicStudy createState() => _EconomicStudy();
}

class _EconomicStudy extends State<EconomicStudy>
    with SingleTickerProviderStateMixin {
  List<dynamic>? _economicWords;
  int _currentId = 1;
  late TabController _tabController;
  Map<String, dynamic>? currentItem;

  @override
  void initState() {
    super.initState();
    _loadEconomicWords();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      return;
    }

    if (_tabController.index == 0) {
      beforeNews();
    } else if (_tabController.index == 1) {
      nextNews();
    }
  }

  void nextNews() {
    setState(() {
      _currentId = (_currentId % (_economicWords!.length)) + 1;
      currentItem =
          _economicWords!.firstWhere((item) => item['id'] == _currentId);
    });
  }

  void beforeNews() {
    setState(() {
      _currentId = (_currentId == 1) ? _economicWords!.length : _currentId - 1;
      currentItem =
          _economicWords!.firstWhere((item) => item['id'] == _currentId);
    });
  }

  Future<void> _loadEconomicWords() async {
    final String response =
        await rootBundle.loadString('assets/economicStudy/economic_words.json');
    final data = await json.decode(response);
    setState(() {
      _economicWords = data['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_economicWords == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: titleName('Economic Study'),
          backgroundColor: const Color.fromARGB(255, 150, 207, 254),
          bottom: TabBar(
            controller: _tabController,
            tabs: tabEcoStudyUpDownList,
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    currentItem =
        _economicWords!.firstWhere((item) => item['id'] == _currentId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: titleName('Economic Study'),
          backgroundColor: const Color.fromARGB(255, 150, 207, 254),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.arrow_back), text: 'Previous'),
              Tab(icon: Icon(Icons.arrow_forward), text: 'Next'),
            ],
          )),
      body: TabBarView(
        controller: _tabController,
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                beforeNews();
              } else if (details.primaryVelocity! < 0) {
                nextNews();
              }
            },
            onTap: () {
              beforeNews();
            },
            child: _buildContent(currentItem),
          ),
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                beforeNews();
              } else if (details.primaryVelocity! < 0) {
                nextNews();
              }
            },
            onTap: () {
              nextNews();
            },
            child: _buildContent(currentItem),
          ),
        ],
      ),
    );
  }

  Padding _buildContent(currentItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
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

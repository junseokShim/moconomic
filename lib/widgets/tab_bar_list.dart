import 'package:flutter/material.dart';

List<Widget> get tabBarList {
  return const [
    Tab(
      icon: Icon(Icons.newspaper_rounded),
      text: "latest-news",
    ),
    Tab(
      icon: Icon(Icons.money_rounded),
      text: "economic-news",
    ),
    Tab(
      icon: Icon(Icons.currency_bitcoin_rounded),
      text: "crypto",
    ),
  ];
}

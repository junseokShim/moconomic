import 'package:flutter/material.dart';

Widget titleName(String? content) {
  return Text(
    '$content',
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 25,
    ),
  );
}

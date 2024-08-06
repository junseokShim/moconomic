import 'package:flutter/material.dart';

Padding ContentCard(message, icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          size: 22,
        ),
        Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}

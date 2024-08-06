import 'package:flutter/material.dart';
import 'dart:math';

class PagePopup extends StatelessWidget {
  final String name, code, amount;
  final bool isInverted;
  final double order;
  final Function function;
  final String? bgImage;

  const PagePopup(
      {super.key,
      required this.name,
      required this.code,
      required this.amount,
      required this.isInverted,
      required this.order,
      required this.function,
      this.bgImage});

  @override
  Widget build(BuildContext context) {
    final randomColor = Color.fromARGB(
      255,
      255, // 128 이상 255 이하의 값 생성
      196 + Random().nextInt(64), // 128 이상 255 이하의 값 생성
      196 + Random().nextInt(64), // 128 이상 255 이하의 값 생성
    );
    return GestureDetector(
      onTap: () => function(), // 클릭 시 function 호출
      child: Column(
        children: [
          // Background image
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: const Color.fromARGB(95, 202, 202, 202),
                width: 1,
              ),
              image: bgImage != null
                  ? DecorationImage(
                      image: AssetImage(bgImage!),
                      fit: BoxFit.cover,
                    )
                  : null, // 배경 이미지 경로
              color: bgImage == null
                  ? (isInverted
                      ? randomColor.withOpacity(0.7)
                      : Colors.black.withOpacity(0.7))
                  : null, // 배경 이미지 위에 반투명 오버레이 추가
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? Colors.black : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    code,
                    style: TextStyle(
                      color: isInverted ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

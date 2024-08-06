import 'dart:math';

import 'package:flutter/material.dart';

class PageCard extends StatelessWidget {
  final String name, code, amount;
  final String? bgImage;
  final IconData? icon;
  final bool isInverted;
  final num order;
  final Widget function;

  const PageCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    this.icon,
    required this.isInverted,
    required this.order,
    required this.function,
    this.bgImage,
  });

  @override
  Widget build(BuildContext context) {
    final randomColor = Color.fromARGB(
      255,
      128, // 128 이상 255 이하의 값 생성
      128 + Random().nextInt(128), // 128 이상 255 이하의 값 생성
      128 + Random().nextInt(128), // 128 이상 255 이하의 값 생성
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => function),
        );
      },
      child: Transform.translate(
        offset: Offset(0, -1.0 * 20 * order.toDouble()),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              image: bgImage != null
                  ? DecorationImage(
                      image: AssetImage(bgImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: bgImage == null
                  ? randomColor
                  : (isInverted
                      ? const Color.fromARGB(95, 215, 224, 255)
                      : const Color(0xFF1F2133)),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: const Color.fromARGB(95, 202, 202, 202), width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                          color: isInverted ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(code,
                            style: TextStyle(
                              color: isInverted
                                  ? Colors.black.withOpacity(0.8)
                                  : Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 2.2,
                  child: Transform.translate(
                    offset: const Offset(-5, 12),
                    child: Icon(
                      icon,
                      color: isInverted ? Colors.black : Colors.white,
                      size: 66,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueHeaderCell extends StatelessWidget {
  const QueueHeaderCell({Key? key, required this.text}) : super(key: key);

  final String text;

  static const height = 12 + 2 * padding + _height;
  static const width = 2 * padding+ _width ;

  static const padding = 2.0;
  static const _width = 60.0;
  static const _height = 40.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surfaceVariant.withOpacity(.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: SizedBox(
          height: _height,
          width: _width,
          child: Center(child: Text(text.toUpperCase(), style: Get.textTheme.labelLarge)),
        ),
      ),
    );
  }
}

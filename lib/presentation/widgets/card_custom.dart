import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  const CardCustom({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 8,
              color: Colors.black.withOpacity(0.1),
            )
          ]),
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}

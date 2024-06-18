import "dart:math";

import "package:flutter/material.dart";

class BaseWidget extends StatelessWidget {
  final Color backgroundColor;
  final Function()? onTap;
  final Function()? onLongPress;
  final EdgeInsetsGeometry? padding;
  final String? title;
  final Widget child;

  const BaseWidget({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    double brightness = sqrt(
      pow(backgroundColor.red, 2) * 0.241 
      + pow(backgroundColor.green, 2) * 0.691 
      + pow(backgroundColor.blue, 2) * 0.068);
    Color foregroundColor = brightness < 150 ? Colors.white : Colors.black;
    final Widget inChild = Padding(
      padding: padding ?? const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null && title != ''
          ? Text(
            title ?? '',
            style: TextStyle(
              color: foregroundColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
          : const SizedBox(),
          title != null && title != '' ? Divider(color: foregroundColor) : const SizedBox(),
          child,
        ],
      ),
    );

    return Card(
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: onTap != null || onLongPress != null
        ? InkWell(
          splashFactory: InkRipple.splashFactory,
          borderRadius: BorderRadius.circular(10),
          highlightColor: Colors.black.withOpacity(0.05),
          splashColor: Colors.black.withOpacity(0.1),
          onTap: onTap,
          onLongPress: onLongPress,
          child: inChild,
        )
        : inChild,
      ),
    );
  }
}
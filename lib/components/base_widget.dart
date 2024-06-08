import "package:flutter/material.dart";

class BaseWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Function()? onTap;
  final Function()? onLongPress;
  final Widget child;

  const BaseWidget({
    super.key,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
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
          child: child,
        )
        : child,
      ),
    );
  }
}
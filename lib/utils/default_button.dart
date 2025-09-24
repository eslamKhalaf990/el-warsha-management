import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'const_values.dart';
import 'default_text.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.margin,
    this.isValid,
    this.border,
    this.isLoading, this.icon, this.height,
  });
  final void Function() onTap;
  final String title;
  final EdgeInsetsGeometry margin;
  final double? border;
  final bool? isValid;
  final bool? isLoading;
  final Icon? icon;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      margin: margin,
      decoration: BoxDecoration(
        color: isValid ?? true
            ? Colors.blue.shade500
            : Colors.blue.shade500.withAlpha(Constants.OPACITY_08),
        borderRadius: BorderRadius.circular(border ?? 15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(border ?? 15.0),
        child: MaterialButton(
          onPressed: isValid == null || isValid! ? onTap : null,
          child: Center(
            child: isLoading ?? false
                ? const SpinKitThreeBounce(
              size: 20,
              color: Colors.white,
            )
                : DefaultText(
              txt: title,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AppPadding extends ThemeExtension<AppPadding> {
  final EdgeInsets globalPadding;

  const AppPadding({required this.globalPadding});

  @override
  AppPadding copyWith({EdgeInsets? globalPadding}) {
    return AppPadding(
      globalPadding: globalPadding ?? this.globalPadding,
    );
  }

  @override
  AppPadding lerp(ThemeExtension<AppPadding>? other, double t) {
    if (other is! AppPadding) return this;
    return AppPadding(
      globalPadding: EdgeInsets.lerp(globalPadding, other.globalPadding, t)!,
    );
  }
}

class Insets {
  static double xxs = 4.0;
  static double xs = 8.0;
  static double sm = 12.0;
  static double md = 16.0;
  static double lg = 24.0;
  static double xl = 32.0;
  static double xxl = 48.0;
  static changeInsets({
    double? newxxs,
    double? newxs,
    double? newsm,
    double? newmd,
    double? newlg,
    double? newxl,
    double? newxxl,
  }) {
    if (newxxs != null) xxs = newxxs;
    if (newxs != null) xs = newxs;
    if (newsm != null) sm = newsm;
    if (newmd != null) md = newmd;
    if (newlg != null) lg = newlg;
    if (newxl != null) xl = newxl;
    if (newxxl != null) xxl = xxl;
  }
}

// create constracture for change these values
class AppTheme extends InheritedTheme {
  final AppPadding padding;

  const AppTheme({
    required this.padding,
    required super.child,
    super.key,
  });

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppTheme(
      padding: padding,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return padding != oldWidget.padding;
  }

  static AppPadding of(BuildContext context) {
    final AppTheme? appTheme =
        context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return appTheme!.padding;
  }
}

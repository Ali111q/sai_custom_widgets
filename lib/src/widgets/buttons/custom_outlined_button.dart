import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../config/config.dart';

/// A custom outlined button that adapts to both iOS and Android platforms.
///
/// This button supports an outlined style with customizable border color,
/// text color, loading states, and icons. It adapts to platform-specific
/// widgets: [Cupertino] for iOS and [Material] for Android.
class CustomOutlinedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Function()? onPressed;
  final double? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final double? padding;
  final bool isLoading;
  final bool isDisabled;
  final bool isIcon;
  final Icon? icon;
  final Widget? loadingWidget;
  final bool fullLoading;

  /// Creates a [CustomOutlinedButton].
  ///
  /// The [text] parameter is required to display the button label.
  const CustomOutlinedButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.onPressed,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.isLoading = false,
    this.isDisabled = false,
    this.isIcon = false,
    this.icon,
    this.loadingWidget,
    this.fullLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoOutlinedButton(context)
        : _buildMaterialOutlinedButton(context);
  }

  /// Builds a Cupertino-styled outlined button for iOS.
  Widget _buildCupertinoOutlinedButton(BuildContext context) {
    final Color effectiveBorderColor = isDisabled
        ? CupertinoColors.quaternarySystemFill
        : (borderColor ?? CupertinoColors.activeBlue);

    final Color effectiveTextColor = isDisabled
        ? CupertinoColors.quaternarySystemFill
        : (textColor ?? CupertinoColors.activeBlue);

    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: EdgeInsets.all(padding ?? Insets.md),
      decoration: BoxDecoration(
        border: Border.all(color: effectiveBorderColor, width: 2),
        borderRadius: BorderRadius.circular(borderRadius ?? Insets.md),
      ),
      child: Center(
        child: _buildContent(context, effectiveTextColor),
      ),
    );
  }

  /// Builds a Material-styled outlined button for Android.
  Widget _buildMaterialOutlinedButton(BuildContext context) {
    final Color effectiveBorderColor = isDisabled
        ? context.theme.colorScheme.onSurface.withOpacity(0.2)
        : (borderColor ?? context.theme.colorScheme.primary);

    final Color effectiveTextColor = isDisabled
        ? context.theme.colorScheme.onSurface.withOpacity(0.4)
        : (textColor ?? context.theme.colorScheme.primary);

    return InkWell(
      onTap: isDisabled || isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? Insets.md),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: EdgeInsets.all(padding ?? Insets.md),
        decoration: BoxDecoration(
          border: Border.all(color: effectiveBorderColor, width: 2),
          borderRadius: BorderRadius.circular(borderRadius ?? Insets.md),
        ),
        child: Center(
          child: _buildContent(context, effectiveTextColor),
        ),
      ),
    );
  }

  /// Builds the content (text, icon, loading indicator) of the outlined button.
  ///
  /// The [effectiveTextColor] is used to style the text and icon colors.
  Widget _buildContent(BuildContext context, Color effectiveTextColor) {
    if (fullLoading && isLoading) {
      return loadingWidget ??
          CircularProgressIndicator(
            color: effectiveTextColor,
          );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading) ...[
          CircularProgressIndicator(
            color: effectiveTextColor,
          ),
          Gap(Insets.sm),
        ] else if (isIcon) ...[
          icon ?? Icon(Icons.add, color: effectiveTextColor),
          Gap(Insets.sm),
        ],
        Text(
          text,
          style: context.textTheme.labelLarge?.copyWith(
            color: effectiveTextColor,
            fontSize: fontSize ?? 16,
          ),
        ),
      ],
    );
  }
}

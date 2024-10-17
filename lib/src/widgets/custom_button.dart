import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'dart:io'; // Platform detection
import 'package:get/get.dart';

import '../config/config.dart';

/// A custom button that adapts to both iOS and Android platforms.
///
/// This button supports various styles such as outlined, loading states,
/// icons, and is highly customizable with properties like color, text color,
/// border radius, and more.
///
/// The button will automatically detect the platform and render the appropriate
/// widget: [CupertinoButton] for iOS and a [Material] button for Android.
class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Function()? onPressed;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final double? padding;
  final bool isOutlined;
  final bool isLoading;
  final bool isDisabled;
  final bool isIcon;
  final Icon? icon;
  final Widget? loadingWidget;
  final bool fullLoading;

  /// Creates a [CustomButton].
  ///
  /// The [text] parameter is required to display the button label.
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.onPressed,
    this.borderRadius,
    this.color,
    this.textColor,
    this.fontSize,
    this.padding,
    this.isOutlined = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.isIcon = false,
    this.icon,
    this.loadingWidget,
    this.fullLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the platform is iOS or Android
    return Platform.isIOS
        ? _buildCupertinoButton(context)
        : _buildMaterialButton(context);
  }

  /// Builds a Cupertino-styled button for iOS.
  Widget _buildCupertinoButton(BuildContext context) {
    final Color buttonColor = isDisabled
        ? CupertinoColors.quaternarySystemFill
        : (isOutlined
            ? Colors.transparent
            : (color ?? context.theme.colorScheme.primary));

    final Color effectiveTextColor = isOutlined
        ? (color ?? context.theme.colorScheme.primary)
        : (textColor ?? CupertinoColors.white);

    return CupertinoButton(
      padding: EdgeInsets.all(padding ?? Insets.md),
      color: isOutlined ? Colors.transparent : buttonColor,
      borderRadius: BorderRadius.circular(borderRadius ?? Insets.md),
      disabledColor: context.theme.colorScheme.primary,
      onPressed: isDisabled || isLoading ? null : onPressed,
      child: _buildContent(context, effectiveTextColor),
    );
  }

  /// Builds a Material-styled button for Android.
  Widget _buildMaterialButton(BuildContext context) {
    final Color buttonColor = isDisabled
        ? context.theme.colorScheme.onSurface.withOpacity(0.2)
        : (isOutlined
            ? Colors.transparent
            : (color ?? context.theme.colorScheme.primary));

    final Color effectiveTextColor = isOutlined
        ? (color ?? context.theme.colorScheme.primary)
        : (textColor ?? context.theme.colorScheme.onPrimary);

    return InkWell(
      onTap: isDisabled || isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? Insets.md),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: EdgeInsets.all(padding ?? Insets.md),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius ?? Insets.md),
          border: isOutlined
              ? Border.all(
                  color: color ?? context.theme.colorScheme.primary,
                  width: 2.0,
                )
              : null,
        ),
        child: Center(
          child: _buildContent(context, effectiveTextColor),
        ),
      ),
    );
  }

  /// Builds the content (text, icon, loading indicator) of the button.
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
            color: isDisabled
                ? context.theme.colorScheme.onSurface.withOpacity(0.4)
                : effectiveTextColor,
            fontSize: fontSize ?? 16,
          ),
        ),
      ],
    );
  }
}

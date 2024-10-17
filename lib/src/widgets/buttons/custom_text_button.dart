import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// A custom text button that adapts to both iOS and Android platforms.
///
/// This button supports text-only buttons with customizable loading states,
/// icons, and text color. It adapts to platform-specific widgets: [CupertinoButton]
/// for iOS and [TextButton] for Android.
class CustomTextButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final void Function()? onPressed;
  final Color? textColor;
  final double? fontSize;
  final bool isLoading;
  final bool isDisabled;
  final bool isIcon;
  final Icon? icon;
  final Widget? loadingWidget;
  final bool fullLoading;

  /// Creates a [CustomTextButton].
  ///
  /// The [text] parameter is required to display the button label.
  const CustomTextButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.onPressed,
    this.textColor,
    this.fontSize,
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
        ? _buildCupertinoTextButton(context)
        : _buildMaterialTextButton(context);
  }

  /// Builds a Cupertino-styled text button for iOS.
  Widget _buildCupertinoTextButton(BuildContext context) {
    final Color effectiveTextColor = isDisabled
        ? CupertinoColors.quaternarySystemFill
        : (textColor ?? CupertinoColors.activeBlue);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isDisabled || isLoading ? null : onPressed,
      child: _buildContent(context, effectiveTextColor),
    );
  }

  /// Builds a Material-styled text button for Android.
  Widget _buildMaterialTextButton(BuildContext context) {
    final Color effectiveTextColor = isDisabled
        ? context.theme.colorScheme.onSurface.withOpacity(0.4)
        : (textColor ?? context.theme.colorScheme.primary);

    return TextButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      child: _buildContent(context, effectiveTextColor),
    );
  }

  /// Builds the content (text, icon, loading indicator) of the text button.
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
          const SizedBox(width: 8),
        ] else if (isIcon) ...[
          icon ?? Icon(Icons.add, color: effectiveTextColor),
          const SizedBox(width: 8),
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

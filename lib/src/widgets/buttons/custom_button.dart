import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'dart:io'; // Platform detection
import 'package:get/get.dart';

import '../../config/config.dart';

/// A cross-platform custom button that adapts to both iOS and Android platforms.
///
/// The [CustomButton] widget can be used to create buttons that are styled differently
/// for iOS and Android, while keeping the same API for developers. It supports various
/// customizations such as outlined style, loading state, icon integration, and different
/// text and background colors.
///
/// ### Features:
/// - **Platform-specific rendering**: Uses [CupertinoButton] for iOS and [Material] button widgets for Android.
/// - **Customization options**: Set custom colors, border radius, padding, and more.
/// - **Loading and disabled states**: Easily manage loading spinners and disable interactions.
/// - **Icon support**: Add an icon before the button text.
class CustomButton extends StatelessWidget {
  /// The width of the button. Defaults to [double.infinity] for full-width buttons.
  final double? width;

  /// The height of the button. Optional.
  final double? height;

  /// The text displayed on the button. This is a required field.
  final String text;

  /// The callback function that is triggered when the button is pressed.
  /// If `null`, the button will be disabled.
  final Function()? onPressed;

  /// The border radius for the button, which controls the roundness of the corners.
  final double? borderRadius;

  /// The background color of the button. If not specified, it defaults to the primary theme color.
  final Color? color;

  /// The color of the text displayed on the button.
  final Color? textColor;

  /// The font size of the button text. Defaults to 16.
  final double? fontSize;

  /// The padding inside the button. If not specified, a default value is used.
  final double? padding;

  /// Indicates if the button should be styled as an outlined button.
  /// When `true`, the button will have a transparent background with a border.
  final bool isOutlined;

  /// Displays a loading indicator in the button when `true`. The button becomes unclickable.
  final bool isLoading;

  /// Disables the button when `true`, preventing interaction.
  final bool isDisabled;

  /// Indicates if an icon should be displayed next to the text.
  final bool isIcon;

  /// The icon to display next to the button text. Only visible when [isIcon] is `true`.
  final Icon? icon;

  /// A custom widget to display as a loading indicator. If not provided, a default [CircularProgressIndicator] is shown.
  final Widget? loadingWidget;

  /// When `true`, the button displays a full-size loading indicator, replacing the button content entirely.
  final bool fullLoading;

  /// Creates a [CustomButton].
  ///
  /// The [text] parameter is required to display the button label, and [onPressed] controls the button's interactivity.
  ///
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
    // Detect the platform and render the appropriate button widget.
    return Platform.isIOS
        ? _buildCupertinoButton(context)
        : _buildMaterialButton(context);
  }

  /// Builds an iOS-styled [CupertinoButton].
  ///
  /// This method returns a [CupertinoButton] with the appropriate styling,
  /// including handling for the outlined state, disabled state, and loading indicators.
  Widget _buildCupertinoButton(BuildContext context) {
    // Set button background color based on whether it's outlined or disabled.
    final Color buttonColor = isDisabled
        ? CupertinoColors.quaternarySystemFill
        : (isOutlined
            ? Colors.transparent
            : (color ?? context.theme.colorScheme.primary));

    // Set the text color based on whether the button is outlined.
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

  /// Builds an Android-styled button with [InkWell] and [Container].
  ///
  /// This method returns a Material-like button for Android devices, including
  /// support for the outlined state, disabled state, and loading indicators.
  Widget _buildMaterialButton(BuildContext context) {
    // Set button background color based on whether it's outlined or disabled.
    final Color buttonColor = isDisabled
        ? context.theme.colorScheme.onSurface.withOpacity(0.2)
        : (isOutlined
            ? Colors.transparent
            : (color ?? context.theme.colorScheme.primary));

    // Set the text color based on whether the button is outlined.
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

  /// Builds the content of the button, including text, icons, and loading indicators.
  ///
  /// This method is used by both the Cupertino and Material button styles to
  /// display the appropriate content. The [effectiveTextColor] is passed to style
  /// the text and icons accordingly.
  Widget _buildContent(BuildContext context, Color effectiveTextColor) {
    // Display a full-size loading indicator if `fullLoading` is true.
    if (fullLoading && isLoading) {
      return loadingWidget ??
          CircularProgressIndicator(
            color: effectiveTextColor,
          );
    }

    // Build the content row with text and optional icon or loading indicator.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Show a loading spinner if `isLoading` is true.
        if (isLoading) ...[
          CircularProgressIndicator(
            color: effectiveTextColor,
          ),
          Gap(Insets.sm),
        ]
        // Show an icon if `isIcon` is true.
        else if (isIcon) ...[
          icon ?? Icon(Icons.add, color: effectiveTextColor),
          Gap(Insets.sm),
        ],
        // Show the button text.
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

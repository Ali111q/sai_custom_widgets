import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io'; // for platform detection

class PlatformNativeListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leading;
  final Widget? trailing; // New trailing widget
  final VoidCallback onTap;
  final BoxBorder? border; // Optional border
  final BorderRadiusGeometry? borderRadius; // Optional border radius

  const PlatformNativeListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.leading,
    this.trailing, // Accept trailing widget
    required this.onTap,
    this.border,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoListTile(context)
        : _buildMaterialListTile();
  }

  Widget _buildMaterialListTile() {
    return Container(
      decoration: BoxDecoration(
        border: border, // Apply the border if provided
        borderRadius: borderRadius, // Apply the border radius if provided
      ),
      child: ListTile(
        leading: leading,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing:
            trailing ?? const Icon(Icons.arrow_forward), // Dynamic trailing
        onTap: onTap,
      ),
    );
  }

  Widget _buildCupertinoListTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border, // Apply the border if provided
        borderRadius: borderRadius, // Apply the border radius if provided
      ),
      child: CupertinoListTile(
        leading: leading,
        title: Text(title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 18)),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing:
            trailing ?? const CupertinoListTileChevron(), // Dynamic trailing
        onTap: onTap,
      ),
    );
  }

  // Static method for builder pattern
  static Widget builder(
      {required BuildContext context,
      required String title,
      String? subtitle,
      required Widget leading,
      Widget? trailing,
      required VoidCallback onTap,
      BoxBorder? border,
      BorderRadiusGeometry? borderRadius,
      required Widget Function(BuildContext, PlatformNativeListTile?)
          builder}) {
    // Create an instance of PlatformNativeListTile
    final tile = PlatformNativeListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      border: border,
      borderRadius: borderRadius,
    );

    // Return the custom widget built with builderFunction
    return builder(context, tile);
  }
}

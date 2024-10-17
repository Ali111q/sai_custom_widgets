import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io'; // for platform detection
import 'list_tile.dart';

class PlatformNativeListSection extends StatelessWidget {
  final String? sectionHeader;
  final List<PlatformNativeListTile> tiles;
  final EdgeInsetsGeometry? padding;

  const PlatformNativeListSection({
    super.key,
    this.sectionHeader,
    required this.tiles,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoSection(context)
        : _buildMaterialSection(context);
  }

  Widget _buildMaterialSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionHeader != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              sectionHeader!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ),
        ...tiles.map((tile) => Padding(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 4.0),
              child: tile,
            )),
      ],
    );
  }

  Widget _buildCupertinoSection(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      backgroundColor: Theme.of(context).colorScheme.surface,
      header: sectionHeader != null
          ? Text(
              sectionHeader!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          : null,
      children: tiles,
    );
  }

  static Widget builder(BuildContext context,
      {Key? key,
      String? sectionHeader,
      required List<PlatformNativeListTile> tiles,
      EdgeInsetsGeometry? padding,
      required Widget Function(BuildContext, PlatformNativeListSection)
          itemBuilder}) {
    PlatformNativeListSection list = PlatformNativeListSection(
      key: key,
      sectionHeader: sectionHeader,
      tiles: tiles,
      padding: padding,
    );
    return itemBuilder(context, list);
  }
}

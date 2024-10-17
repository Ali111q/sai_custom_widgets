import 'package:flutter/cupertino.dart';

/// Extension methods on [Column] to add padding and spacing functionality.
extension PaddingColumn on Column {
  /// Adds padding around the entire [Column].
  ///
  /// The [padding] parameter allows you to specify how much padding to add. The default
  /// value is 0.0. This method returns a new [Column] widget with the specified padding
  /// applied around the entire column.
  ///
  /// Example usage:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withPadding(padding: 8.0);
  /// ```
  Column withPadding({double padding = 0.0}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: this,
        ),
      ],
    );
  }

  /// Adds symmetric padding (vertical and horizontal) around the [Column].
  ///
  /// The [vertical] and [horizontal] parameters allow you to specify different padding
  /// for the vertical and horizontal directions. The default value for both is 0.0.
  /// This method returns a new [Column] widget with the specified symmetric padding.
  ///
  /// Example usage:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withSymmetricPadding(vertical: 8.0, horizontal: 16.0);
  /// ```
  Column withSymmetricPadding(
      {double vertical = 0.0, double horizontal = 0.0}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: this,
        ),
      ],
    );
  }

  /// Adds padding to the [Column] using left, top, right, and bottom values.
  ///
  /// The [left], [top], [right], and [bottom] parameters allow you to specify padding
  /// on each side of the column individually. This method returns a new [Column]
  /// widget with the specified padding applied.
  ///
  /// Example usage:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withPaddingLTRB(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0);
  /// ```
  Column withPaddingLTRB(
      {double left = 0.0,
      double top = 0.0,
      double right = 0.0,
      double bottom = 0.0}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          child: this,
        ),
      ],
    );
  }

  /// Adds vertical spacing between the children of the [Column].
  ///
  /// The [spacing] parameter allows you to specify how much space to add between
  /// each child of the column. The default value is 0.0. This method returns a new
  /// [Column] widget with the specified spacing applied between its children.
  ///
  /// Example usage:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withSpacing(spacing: 8.0);
  /// ```
  Column withSpacing({double spacing = 0.0}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        for (int i = 0; i < children.length; i++)
          Padding(
            padding:
                EdgeInsets.only(bottom: i == children.length - 1 ? 0 : spacing),
            child: children[i],
          ),
      ],
    );
  }
}

/// Extension methods on [Row] to add padding and spacing functionality.
extension PaddingRow on Row {
  /// Adds padding around the entire [Row].
  ///
  /// The [padding] parameter allows you to specify how much padding to add. The default
  /// value is 0.0. This method returns a new [Row] widget with the specified padding
  /// applied around the entire row.
  ///
  /// Example usage:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withPadding(padding: 8.0);
  /// ```
  Row withPadding({double padding = 0.0}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: this,
        ),
      ],
    );
  }

  /// Adds symmetric padding (vertical and horizontal) around the [Row].
  ///
  /// The [vertical] and [horizontal] parameters allow you to specify different padding
  /// for the vertical and horizontal directions. The default value for both is 0.0.
  /// This method returns a new [Row] widget with the specified symmetric padding.
  ///
  /// Example usage:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withSymmetricPadding(vertical: 8.0, horizontal: 16.0);
  /// ```
  Row withSymmetricPadding({double vertical = 0.0, double horizontal = 0.0}) {
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          child: this,
        ),
      ],
    );
  }

  /// Adds padding to the [Row] using left, top, right, and bottom values.
  ///
  /// The [left], [top], [right], and [bottom] parameters allow you to specify padding
  /// on each side of the row individually. This method returns a new [Row]
  /// widget with the specified padding applied.
  ///
  /// Example usage:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withPaddingLTRB(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0);
  /// ```
  Row withPaddingLTRB(
      {double left = 0.0,
      double top = 0.0,
      double right = 0.0,
      double bottom = 0.0}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          child: this,
        ),
      ],
    );
  }

  /// Adds horizontal spacing between the children of the [Row].
  ///
  /// The [spacing] parameter allows you to specify how much space to add between
  /// each child of the row. The default value is 0.0. This method returns a new
  /// [Row] widget with the specified spacing applied between its children.
  ///
  /// Example usage:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text("Item 1"),
  ///     Text("Item 2"),
  ///   ],
  /// ).withSpacing(spacing: 8.0);
  /// ```
  Row withSpacing({double spacing = 0.0}) {
    return Row(
      children: children
          .map((e) => Padding(
                padding: EdgeInsets.only(right: spacing),
                child: e,
              ))
          .toList(),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

typedef DatePickerBuilder = Widget Function(
  BuildContext context,
  DateTime selectedDate,
);

/// A custom date picker widget that provides both iOS and Android-style date pickers,
/// depending on the platform. The date picker can be triggered by tapping on the widget,
/// and the selected date will be displayed.
///
/// This widget supports both [CupertinoDatePicker] for iOS and [showDatePicker] for Android.
///
/// {@tool dartpad}
/// This example demonstrates how to use the [CustomDatePickerWidget].
///
/// The [CustomDatePickerWidget] is wrapped in a [GestureDetector] to handle tap events,
/// opening the appropriate date picker depending on the platform. The selected date
/// is displayed in the widget.
///
/// ```dart
/// CustomDatePickerWidget(
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2000),
///   lastDate: DateTime(2100),
///   onDateSelected: (DateTime newDate) {
///     print("Selected date: $newDate");
///   },
/// );
/// ```
/// {@end-tool}
///
/// See also:
///  * [showCupertinoModalPopup], for displaying a modal popup in iOS.
///  * [showDatePicker], for displaying a date picker in Android.
class CustomDatePickerWidget extends StatefulWidget {
  /// The initial date to display in the date picker.
  final DateTime initialDate;

  /// The earliest date the user can select.
  final DateTime firstDate;

  /// The latest date the user can select.
  final DateTime lastDate;

  /// A callback function that is called when a date is selected.
  final Function(DateTime) onDateSelected;

  /// Creates a [CustomDatePickerWidget].
  ///
  /// The [initialDate], [firstDate], [lastDate], and [onDateSelected] parameters are required.
  const CustomDatePickerWidget({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  /// A builder method that allows customizing the UI of the date picker widget.
  ///
  /// This method provides a flexible way to build the date picker widget with a custom layout
  /// using the [builder] parameter.
  ///
  /// Example:
  /// ```dart
  /// CustomDatePickerWidget.builder(
  ///   initialDate: DateTime.now(),
  ///   firstDate: DateTime(2000),
  ///   lastDate: DateTime(2100),
  ///   onDateSelected: (DateTime newDate) {
  ///     print("Selected date: $newDate");
  ///   },
  ///   builder: (context, selectedDate) {
  ///     return Text("Selected Date: ${selectedDate.toLocal()}");
  ///   },
  /// );
  /// ```
  static Widget builder({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Function(DateTime) onDateSelected,
    required DatePickerBuilder builder,
  }) {
    return _CustomDatePickerBuilder(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateSelected: onDateSelected,
      builder: builder,
    );
  }

  @override
  _CustomDatePickerWidgetState createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  /// Displays the appropriate date picker based on the platform.
  ///
  /// For iOS, it shows a [CupertinoDatePicker]. For Android, it uses [showDatePicker].
  void _showDatePicker() async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => _buildCupertinoDatePicker(context),
      );
    } else {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
      );

      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
        widget.onDateSelected(picked);
      }
    }
  }

  /// Builds the Cupertino date picker for iOS.
  Widget _buildCupertinoDatePicker(BuildContext context) {
    return Container(
      height: 250,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.date,
              minimumDate: widget.firstDate,
              maximumDate: widget.lastDate,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
                widget.onDateSelected(newDate);
              },
            ),
          ),
          CupertinoButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_selectedDate.toLocal()}".split(' ')[0],
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}

/// A private widget that handles the custom date picker builder functionality.
class _CustomDatePickerBuilder extends StatefulWidget {
  /// The initial date to display in the date picker.
  final DateTime initialDate;

  /// The earliest date the user can select.
  final DateTime firstDate;

  /// The latest date the user can select.
  final DateTime lastDate;

  /// A callback function that is called when a date is selected.
  final Function(DateTime) onDateSelected;

  /// A custom builder for the widget's UI.
  final DatePickerBuilder builder;

  const _CustomDatePickerBuilder({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    required this.builder,
  });

  @override
  __CustomDatePickerBuilderState createState() =>
      __CustomDatePickerBuilderState();
}

class __CustomDatePickerBuilderState extends State<_CustomDatePickerBuilder> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  /// Displays the appropriate date picker based on the platform.
  ///
  /// For iOS, it shows a [CupertinoDatePicker]. For Android, it uses [showDatePicker].
  void _showDatePicker() async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => _buildCupertinoDatePicker(context),
      );
    } else {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
      );

      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
        widget.onDateSelected(picked);
      }
    }
  }

  /// Builds the Cupertino date picker for iOS.
  Widget _buildCupertinoDatePicker(BuildContext context) {
    return Container(
      height: 250,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.date,
              minimumDate: widget.firstDate,
              maximumDate: widget.lastDate,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
                widget.onDateSelected(newDate);
              },
            ),
          ),
          CupertinoButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(),
      child: widget.builder(context, _selectedDate),
    );
  }
}

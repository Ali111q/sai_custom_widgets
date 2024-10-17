// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

class CustomSwitch extends StatefulWidget {
  final ValueChanged<bool> onSwitch;
  final bool? initialValue; // Optional initial value

  // Constructor that takes in the onSwitch callback and optional initial value
  const CustomSwitch({
    super.key,
    required this.onSwitch,
    this.initialValue,
  });

  // Static builder method for creating a CustomSwitch with a builder function
  static Widget builder({
    required ValueChanged<bool> onSwitch,
    bool? initialValue,
    required Widget Function(BuildContext, bool, ValueChanged<bool>) builder,
  }) {
    return CustomSwitch(
      onSwitch: onSwitch,
      initialValue: initialValue,
    )._builder(builder);
  }

  // Private method to render the builder
  Widget _builder(
      Widget Function(BuildContext, bool, ValueChanged<bool>) builder) {
    return _CustomSwitchBuilder(
      onSwitch: onSwitch,
      initialValue: initialValue,
      builder: builder,
    );
  }

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    // Set the initial switch state based on the provided initialValue or default to false
    _isSwitched = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoSwitch() : _buildMaterialSwitch();
  }

  // iOS Switch (Cupertino)
  Widget _buildCupertinoSwitch() {
    return CupertinoSwitch(
      value: _isSwitched,
      onChanged: (bool value) {
        setState(() {
          _isSwitched = value;
        });
        widget.onSwitch(value); // Call the passed-in onSwitch function
      },
    );
  }

  // Android Switch (Material)
  Widget _buildMaterialSwitch() {
    return Switch(
      value: _isSwitched,
      onChanged: (bool value) {
        setState(() {
          _isSwitched = value;
        });
        widget.onSwitch(value); // Call the passed-in onSwitch function
      },
      activeColor: context.theme.colorScheme.primary,
    );
  }
}

// Custom switch builder
class _CustomSwitchBuilder extends StatefulWidget {
  final ValueChanged<bool> onSwitch;
  final bool? initialValue;
  final Widget Function(BuildContext, bool, ValueChanged<bool>) builder;

  const _CustomSwitchBuilder({
    required this.onSwitch,
    this.initialValue,
    required this.builder,
  });

  @override
  __CustomSwitchBuilderState createState() => __CustomSwitchBuilderState();
}

class __CustomSwitchBuilderState extends State<_CustomSwitchBuilder> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    // Set the initial switch state based on the provided initialValue or default to false
    _isSwitched = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _isSwitched,
      (value) {
        setState(() {
          _isSwitched = value;
        });
        widget.onSwitch(value); // Call the passed-in onSwitch function
      },
    );
  }
}

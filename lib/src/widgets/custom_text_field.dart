import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';
import '../validator/validator.dart';
import '../validator/validator_rule.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final double? borderRadius;
  final List<ValidatorRule>? validators;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.onChanged,
    this.borderRadius,
    this.validators,
    this.onSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildCupertinoTextField();
    } else {
      return _buildMaterialTextField();
    }
  }

  Widget _buildCupertinoTextField() {
    return CupertinoTextField(
      controller: widget.controller,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : widget.keyboardType,
      obscureText: widget.isPassword && !showPassword,
      placeholder: widget.hintText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      padding: EdgeInsets.symmetric(
        horizontal: Insets.md,
        vertical: Insets.sm,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? Insets.xs),
      ),
      suffix: widget.isPassword
          ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                  showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
            )
          : null,
    );
  }

  Widget _buildMaterialTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: Insets.md),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : widget.keyboardType,
        obscureText: widget.isPassword && !showPassword,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        validator: (value) => widget.validators != null
            ? Validator.validate(value, widget.validators!)
            : null,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off))
              : null,
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Insets.md,
            vertical: Insets.sm,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(widget.borderRadius ?? Insets.xs),
          ),
        ),
      ),
    );
  }
}

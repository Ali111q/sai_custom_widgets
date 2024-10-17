// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

abstract class ValidatorRule {
  final String? errorMessage;

  @mustCallSuper
  const ValidatorRule([this.errorMessage]);

  String? isValid(String? value);

  abstract final Map<String, String> defaultMessage;

  String? get getMessage => errorMessage ?? defaultMessage[Get.locale!.languageCode];
}

import 'package:flutter/material.dart';
import 'package:sai_custom_widgets/src/config/config.dart';

class BaseScaffold extends Scaffold {
  const BaseScaffold(
      {super.key,
      super.body,
      super.appBar,
      super.floatingActionButton,
      super.bottomNavigationBar});

  @override
  Widget? get body => Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: super.body,
      );
}
